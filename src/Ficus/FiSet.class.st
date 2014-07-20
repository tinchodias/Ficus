"
I represent a set. TODO
"
Class {
	#name : #FiSet,
	#superclass : #FiShot,
	#type : #variable,
	#category : #'Ficus-Model-Core'
}

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

{ #category : #edits }
FiSet >> at: step edit: aBlockClosure [ 

	| aShot |
	aShot := self shotAt: step.

	^ self include: (aShot resultOf: (aBlockClosure value: aShot))
]

{ #category : #differencing }
FiSet >> differenceFrom: other [

	| subEffects |	
	self == other ifTrue: [ ^ FiNoEffect new ].
	self class == other class ifFalse: [ self shouldBeImplemented ].

	subEffects := Set new.
	
	other stepsAndValuesDo: [ :key :otherValue | 
		self
			shotAt: key
			ifPresent: [ :value | 
				| subDifference |
				subDifference := value differenceFrom: otherValue.
				
				subDifference isNoEffect ifFalse: [
					subEffects add: 
						(FiSetUpdateEffect builder
							theValue: value;
							oldValue: otherValue;
							subEffect: subDifference;
							new) ] ]
			ifAbsent: [ 
				subEffects add: 
					(FiSetRemoveEffect builder
						theValue: otherValue;
						new) ] ].

	self stepsAndValuesDo: [ :key :value |
		(other steps includes: key) ifFalse: [ 
			subEffects add: 
				(FiSetAddEffect builder
					theValue: value;
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

{ #category : #effects }
FiSet >> effectOfExclude: anExclude [ 

	^ self 
		shotAt: anExclude theValue defaultStep
		ifPresent: [ :aValue | anExclude effectRemove: aValue ]
		ifAbsent: [ anExclude effectNothing ]
]

{ #category : #effects }
FiSet >> effectOfInclude: anInclude [ 

	^ self 
		shotAt: anInclude theValue defaultStep
		ifPresent: [ :aValue | 
			| difference |
			difference := anInclude theValue differenceFrom: aValue.
			
			difference isNoEffect
				ifTrue: [ anInclude effectNothing ]
				ifFalse: [ 
					FiSetUpdateEffect builder
						theValue: anInclude theValue;
						oldValue: aValue;
						subEffect: difference;
						new ] ] 
		ifAbsent: [ anInclude effectAdd ].
]

{ #category : #edits }
FiSet >> exclude: aValue [

	^ FiExclude value: aValue
]

{ #category : #edits }
FiSet >> include: aValue [

	^ FiInclude value: aValue
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
		shotAt: anAcceptKey key
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

{ #category : #accessing }
FiSet >> shotAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ self 
		indexOf: step 
		ifPresent: [ :index | presentBlock value: (self at: index) ]
		ifAbsent: absentBlock
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
