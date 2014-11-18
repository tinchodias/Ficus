"
I represent a set. TODO
"
Class {
	#name : #FiSet,
	#superclass : #FiShot,
	#type : #variable,
	#category : #'Ficus-Model-Core'
}

{ #category : #ston }
FiSet class >> fromSton: stonReader [

	| values |
	values := Array streamContents: [ :stream |
		stonReader parseListDo: [ :each | 
			stream nextPut: each ]].
	
	^ self withValues: values
]

{ #category : #'instance creation' }
FiSet class >> new [

	^ self withValues: #()
]

{ #category : #'instance creation' }
FiSet class >> newFromStepsAndValues: aDictionary [ 
	
	^ self withValues: aDictionary values
]

{ #category : #'instance creation' }
FiSet class >> withValues: aCollection [ 
	
	^ (self basicNew: aCollection size)
		initializeWithValues: aCollection;
		yourself
]

{ #category : #converting }
FiSet >> asArray [
	
	^ (1 to: self size) collect: [ :index | self at: index ] as: Array
]

{ #category : #converting }
FiSet >> asDictionary [

	| result |
	result := Dictionary new.

	self stepsAndValuesDo: [ :step :value |
		result at: step put: value ].
	
	^ result
]

{ #category : #differencing }
FiSet >> differenceFrom: other [

	| subEffects |	
	self == other ifTrue: [ ^ FiNoEffect new ].
	self class == other class ifFalse: [ ^ self effectOfReplace: other ].

	subEffects := Set new.
	
	other stepsAndValuesDo: [ :key :otherValue | 
		self
			valueAt: key
			ifPresent: [ :value | 
				| subDifference |
				subDifference := value differenceFrom: otherValue.
				
				subDifference isNoEffect ifFalse: [
					subEffects add: 
						(FiSetUpdate builder
							newValue: value;
							oldValue: otherValue;
							subEffect: subDifference;
							new) ] ]
			ifAbsent: [ 
				subEffects add: 
					(FiSetRemoval builder
						oldValue: otherValue;
						new) ] ].

	self stepsAndValuesDo: [ :key :value |
		(other steps includes: key) ifFalse: [ 
			subEffects add: 
				(FiSetAddition builder
					newValue: value;
					new) ] ].
	
	^ subEffects
		ifEmpty: [ FiNoEffect new ]
		ifNotEmpty: [ subEffects size = 1
			ifTrue: [ subEffects anyOne ]
			ifFalse: [ 
				FiCompositeEffect builder
					subEffects: (FiSet withValues: subEffects);
					new ] ]
]

{ #category : #edits }
FiSet >> editAt: step do: aBlockClosure [ 

	| aShot |
	aShot := self valueAt: step.

	^ self editInclude: (aShot resultOf: (aBlockClosure value: aShot))
]

{ #category : #edits }
FiSet >> editExclude: aValue [

	^ FiExclude value: aValue
]

{ #category : #edits }
FiSet >> editInclude: aValue [

	^ FiInclude value: aValue
]

{ #category : #effects }
FiSet >> effectOfExclude: anExclude [ 

	^ self 
		valueAt: anExclude theValue defaultStep
		ifPresent: [ :aValue | anExclude effectRemove: aValue ]
		ifAbsent: [ anExclude effectNothing ]
]

{ #category : #effects }
FiSet >> effectOfInclude: anInclude [ 

	^ self 
		valueAt: anInclude theValue defaultStep
		ifPresent: [ :aValue | 
			| difference |
			difference := anInclude theValue differenceFrom: aValue.
			
			difference isNoEffect
				ifTrue: [ anInclude effectNothing ]
				ifFalse: [ 
					FiSetUpdate builder
						newValue: anInclude theValue;
						oldValue: aValue;
						subEffect: difference;
						new ] ] 
		ifAbsent: [ anInclude effectAdd ].
]

{ #category : #private }
FiSet >> indexOf: step ifPresent: presentBlock ifAbsent: absentBlock [

	self valuesWithIndexDo: [ :each :index | 
		each defaultStep = step ifTrue: [ ^ presentBlock cull: index ] ].

	^ absentBlock value
]

{ #category : #initialization }
FiSet >> initializeWithValues: aCollection [ 

	| index |	
	self initialize.
	
	index := 1.
	aCollection do: [ :each | 
		self at: index put: each. 
		index := index + 1 ]
]

{ #category : #testing }
FiSet >> isEmpty [
	
	^ self stepCount = 0
]

{ #category : #printing }
FiSet >> printOn: aStream [

	super printOn: aStream.
	self values printElementsOn: aStream.

]

{ #category : #results }
FiSet >> resultOfAcceptKey: anAcceptKey [ 

	| newValue newValues |
	newValue := self 
		valueAt: anAcceptKey key
		ifPresent: [ :aValue | 
			anAcceptKey edit resultOn: aValue ]
		ifAbsent: [ 
			self flag: #todo. "FIX".
			anAcceptKey edit resultOn: nil ].
		
	newValues := self asArray copyWith: newValue.

	self 
		indexOf: newValue defaultStep 
		ifPresent: [ :index | newValues := newValues copyWithoutIndex: index ]
		ifAbsent: [ ].
		
	^ self species withValues: newValues
]

{ #category : #results }
FiSet >> resultOfExclude: anExclude [ 

	^ self species withValues: (self values copyWithout: anExclude theValue)
]

{ #category : #results }
FiSet >> resultOfInclude: anInclude [ 

	| newValues |
	newValues := self asArray copyWith: anInclude theValue.

	self 
		indexOf: anInclude theValue defaultStep 
		ifPresent: [ :index | newValues := newValues copyWithoutIndex: index ]
		ifAbsent: [ ].
		
	^ self species withValues: newValues
]

{ #category : #enumerating }
FiSet >> stepCount [
	
	^ self size
]

{ #category : #enumerating }
FiSet >> stepsAndValuesDo: aBlockClosure [ 

	^ self valuesDo: [ :each | 
		aBlockClosure 
			value: each defaultStep 
			value: each ]
]

{ #category : #ston }
FiSet >> stonOn: stonWriter [
	"Taken from Collection"

	stonWriter writeObject: self do: [
		stonWriter encodeList: self values ]

]

{ #category : #accessing }
FiSet >> valueAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ self 
		indexOf: step 
		ifPresent: [ :index | presentBlock value: (self at: index) ]
		ifAbsent: absentBlock
]

{ #category : #enumerating }
FiSet >> valuesDo: elementBlock [ 

	^ self valuesWithIndexDo: [ :value :index | elementBlock value: value ]
]

{ #category : #private }
FiSet >> valuesWithIndexDo: elementAndIndexBlock [ 

	1 to: self size do: [ :index |
		elementAndIndexBlock
			value: (self at: index)
			value: index ]
]
