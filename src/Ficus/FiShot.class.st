"
I represent an immutable object which must not form cycles with other FiShots (i.e. a Directed Acyclic Graph). 

A shot has #steps, which are Symbol names which can be used to access corresponding #values.

Each shot provides an #editing protocol that builds ""edits"", i.e. instances of a class in the hierarchy of FiEdit.

Then, an edit can be used to calculate either:
- the result of the application of the edit, with: aShot resultOf: anEdit.
- the effect of the application of the edit, with: aShot effectOf: anEdit.


"
Class {
	#name : #FiShot,
	#superclass : #Object,
	#instVars : [
		'tag',
		'cachedHash'
	],
	#category : #'Ficus-Model-Core'
}

{ #category : #'instance creation' }
FiShot class >> builder [
	
	^ FiShotBuilder forClass: self
]

{ #category : #'instance creation' }
FiShot class >> newFromStepsAndValues: aCollection [ 
	
	^ self basicNew
		initializeFromStepsAndValues: aCollection;
		yourself
]

{ #category : #comparing }
FiShot >> = another [
	
	self == another ifTrue: [ ^ true ].
	self class = another class ifFalse: [ ^ false ].
	self hash = another hash ifFalse: [ ^ false ].
	self stepCount = another stepCount ifFalse: [ ^ false ].
	
	self stepsAndValuesDo: [ :step :value | 
		another 
			shotAt: step 
			ifPresent: [ :otherValue | value = otherValue ifFalse: [ ^ false ] ]
			ifAbsent: [ ^ false ] ].
		
	^ true	

]

{ #category : #differencing }
FiShot >> differenceFrom: other [

	^ self subclassResponsibility 
]

{ #category : #edits }
FiShot >> edits: aCollectionOfEdits [
	
	^ FiCompositeEdit withAll: (FiSet withValues: aCollectionOfEdits)
]

{ #category : #effects }
FiShot >> effectOf: anEdit [ 

	^ anEdit effectOn: self
]

{ #category : #effects }
FiShot >> effectOfCompositeEdit: aCompositeEdit [ 

	^ FiCompositeEffect builder
		subEffects: (FiSet withValues: (aCompositeEdit subEdits values collect: [ :anEdit | anEdit effectOn: self ]));
		new
]

{ #category : #enumerating }
FiShot >> ficusDeepCollect: aBlock basePath: aPath [

	| collectionFromChildren |
	collectionFromChildren := 
		Array streamContents: [ :stream |	
			self stepsAndValuesDo: [ :step :value | 
				stream nextPut: (value ficusDeepCollect: aBlock basePath: (aPath / step)) ]].

	^ aBlock 
		value: self 
		value: aPath 
		value: collectionFromChildren
]

{ #category : #enumerating }
FiShot >> ficusDeepDo: aBlock [

	self stepsAndValuesDo: [ :step :value |
		value ficusDeepDo: aBlock ].

	^ aBlock value: self
]

{ #category : #enumerating }
FiShot >> ficusDeepDo: aBlock basePath: aPath [

	self stepsAndValuesDo: [ :step :value |
		value ficusDeepDo: aBlock basePath: (aPath / step) ].

	^ aBlock 
		value: self 
		value: aPath
]

{ #category : #converting }
FiShot >> flattened [
	
	^ (Array streamContents: [ :stream |
		self 
			ficusDeepDo: [ :value :path | stream nextPut: path -> value ]
			basePath: FiPath root ])
		reversed

]

{ #category : #testing }
FiShot >> hasTag [

	^ self tag isNotNil
]

{ #category : #comparing }
FiShot >> hash [
	
	^ cachedHash ifNil: [ cachedHash := self uncachedHash ]
]

{ #category : #initialization }
FiShot >> initializeFromStepsAndValues: aDictionary [

	self subclassResponsibility 
]

{ #category : #testing }
FiShot >> isShot [
	
	^ true
]

{ #category : #printing }
FiShot >> printOn: aStream [

	super printOn: aStream.

	self tag ifNil: [ ^ self ].

	aStream 
		space;
		nextPut: $[.

	self tag printOn: aStream.

	aStream 
		nextPut: $];
		space.
]

{ #category : #results }
FiShot >> resultOfCompositeEdit: aCompositeEdit [ 

	^ aCompositeEdit subEdits values
		inject: self
		into: [ :copy :edit | copy resultOf: edit ]
]

{ #category : #accessing }
FiShot >> shotAt: step [

	^ self 
		shotAt: step 
		ifPresent: [ :shot | shot ]
		ifAbsent: [ NotFound signal ]
]

{ #category : #accessing }
FiShot >> shotAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ self subclassResponsibility 
]

{ #category : #accessing }
FiShot >> stepCount [
	
	^ self steps size
]

{ #category : #accessing }
FiShot >> steps [

	| result |
	result := Set new.

	self stepsAndValuesDo: [ :step :value |
		result add: step ].

	^ result
]

{ #category : #enumerating }
FiShot >> stepsAndValues [

	| result |
	result := Set new.

	self stepsAndValuesDo: [ :step :value |
		result add: step -> value ].

	^ result
]

{ #category : #enumerating }
FiShot >> stepsAndValuesDo: aBlockClosure [ 

	^ self subclassResponsibility 
]

{ #category : #ston }
FiShot >> stonOn: stonWriter [

	stonWriter 
		writeObject: self 
		streamMap: [ :dictionary | 
			self stepsAndValuesDo: [ :step :value | 
				dictionary at: step put: value ] ]
]

{ #category : #accessing }
FiShot >> tag [
	
	^ tag
]

{ #category : #accessing }
FiShot >> tag: anObject [

	tag := anObject
]

{ #category : #comparing }
FiShot >> uncachedHash [
	
	| hash |
	hash := self class hash.
	
	self stepsAndValuesDo: [ :step :value | 
		hash := (hash bitXor: step hash) bitXor: value hash ].
		
	^ hash
]

{ #category : #accessing }
FiShot >> values [
	
	^ Array streamContents: [ :stream |
		self valuesDo: [ :each | stream nextPut: each ] ]

]

{ #category : #accessing }
FiShot >> valuesDo: elementBlock [
	"Evaluates the block on each value of this object"
	
	^ self stepsAndValuesDo: [ :step :value | elementBlock value: value ]
]
