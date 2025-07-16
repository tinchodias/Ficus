Extension { #name : #FiSet }

{ #category : #'*Ficus-Updates' }
FiSet >> changeFrom: other [

	| changes |	
	self == other ifTrue: [ ^ FiNoChange new ].
	self class == other class ifFalse: [ ^ other changeOfReplaceBy: self ].

	changes := Set new.
	
	other stepsAndValuesDo: [ :key :otherValue | 
		self
			valueAt: key
			ifPresent: [ :value | 
				| subDifference |
				subDifference := value changeFrom: otherValue.
				
				subDifference isNoChange ifFalse: [
					changes add: 
						(FiSetUpdate builder
							newValue: value;
							oldValue: otherValue;
							child: subDifference;
							new) ] ]
			ifAbsent: [ 
				changes add: 
					(FiSetRemoval builder
						oldValue: otherValue;
						new) ] ].

	self stepsAndValuesDo: [ :key :value |
		(other steps includes: key) ifFalse: [ 
			changes add: 
				(FiSetAddition builder
					newValue: value;
					new) ] ].
	
	^ FiChange fromAll: changes
]

{ #category : #'*Ficus-Updates' }
FiSet >> changeOfExclude: anExclude [ 

	^ self 
		valueAt: anExclude theValue defaultStep
		ifPresent: [ :aValue | anExclude changeRemove: aValue ]
		ifAbsent: [ anExclude changeNothing ]
]

{ #category : #'*Ficus-Updates' }
FiSet >> changeOfInclude: anInclude [ 

	^ self 
		valueAt: anInclude theValue defaultStep
		ifPresent: [ :aValue | 
			| difference |
			difference := anInclude theValue changeFrom: aValue.
			
			difference isNoChange
				ifTrue: [ anInclude changeNothing ]
				ifFalse: [ 
					FiSetUpdate builder
						newValue: anInclude theValue;
						oldValue: aValue;
						child: difference;
						new ] ] 
		ifAbsent: [ anInclude changeAdd ].
]

{ #category : #'*Ficus-Updates' }
FiSet >> copyWith: anElement [

	^ self resultOf: (FiInclude value: anElement)
]

{ #category : #'*Ficus-Updates' }
FiSet >> copyWithAll: elements [

	| edit |
	edit := FiEdit fromAll: (elements collect: [ :anElement | 
		FiInclude value: anElement]).

	^ self resultOf: edit
]

{ #category : #'*Ficus-Updates' }
FiSet >> editAt: step do: aBlockClosure [ 

	| aShot |
	aShot := self valueAt: step.

	^ self editInclude: (aShot resultOf: (aBlockClosure value: aShot))
]

{ #category : #'*Ficus-Updates' }
FiSet >> editExclude: aValue [

	^ FiExclude value: aValue
]

{ #category : #'*Ficus-Updates' }
FiSet >> editFromSimpleChange: aSimpleChange [
	"Convert as edit, assuming the FiSimpleChange applies to myself."
	
	aSimpleChange
		ifAdd: [ ^ self editInclude: aSimpleChange newValue ] 
		ifRemove: [ ^ self editExclude: aSimpleChange oldValue ] 
		ifUpdate: [ ].
	
	^ aSimpleChange children asArray
		ifEmpty: [ self editInclude: aSimpleChange newValue ]
		ifNotEmpty: [ :children | 
			self 
				editAtPath: FiPath root / aSimpleChange path step
				do: [ :oneStepForward |
					self editAll: (children collect: [ :each | 
						oneStepForward editFromSimpleChange: each ]) ]].
]

{ #category : #'*Ficus-Updates' }
FiSet >> editInclude: aValue [

	^ FiInclude value: aValue
]

{ #category : #'*Ficus-Updates' }
FiSet >> resultOfExclude: anExclude [ 

	^ self species withValues: (self values copyWithout: anExclude theValue)
]

{ #category : #'*Ficus-Updates' }
FiSet >> resultOfInclude: anInclude [ 

	| newValues |
	newValues := self asArray copyWith: anInclude theValue.

	self 
		indexOf: anInclude theValue defaultStep 
		ifPresent: [ :index | newValues := newValues copyWithoutIndex: index ]
		ifAbsent: [ ].
		
	^ self species withValues: newValues
]
