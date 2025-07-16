"
I represent an immutable object which must not form cycles (i.e. a Directed Acyclic Graph). 

A shot has #steps, which are Symbol names which can be used to access corresponding #values.

Each shot provides an #edits protocol that builds ""edits"", i.e. instances of a class in the hierarchy of FiEdit.

Then, an edit can be used to calculate either:
- the result of the application of the edit, with: aFiObject resultOf: anEdit.
- the change produced by the edit, with: aFiObject changeOf: anEdit.


"
Class {
	#name : #FiObject,
	#superclass : #Object,
	#instVars : [
		'cachedHash'
	],
	#category : #'Ficus-Core-Model'
}

{ #category : #'instance creation' }
FiObject class >> newFromStepsAndValues: aCollection [ 
	
	^ self basicNew
		initializeFromStepsAndValues: aCollection;
		yourself
]

{ #category : #accessing }
FiObject class >> steps [
	"Answer the collection of steps that all of my instances must have."
	
	^ #()
]

{ #category : #comparing }
FiObject >> = another [
	
	self == another ifTrue: [ ^ true ].
	self class = another class ifFalse: [ ^ false ].
	self hash = another hash ifFalse: [ ^ false ].
	self stepCount = another stepCount ifFalse: [ ^ false ].
	
	self stepsAndValuesDo: [ :step :value | 
		another 
			valueAt: step 
			ifPresent: [ :otherValue | value = otherValue ifFalse: [ ^ false ] ]
			ifAbsent: [ ^ false ] ].
		
	^ true	

]

{ #category : #enumerating }
FiObject >> ficusDeepDo: aBlock [

	self stepsAndValuesDo: [ :step :value |
		value ficusDeepDo: aBlock ].

	^ aBlock value: self
]

{ #category : #testing }
FiObject >> hasValueAt: step [

	^ self 
		valueAt: step 
		ifPresent: [ :v | true ]
		ifAbsent: [ false ]
]

{ #category : #comparing }
FiObject >> hash [
	
	^ cachedHash ifNil: [ cachedHash := self uncachedHash ]
]

{ #category : #initialization }
FiObject >> initializeFromStepsAndValues: aDictionary [

	self subclassResponsibility 
]

{ #category : #testing }
FiObject >> isFiObject [
	
	^ true
]

{ #category : #accessing }
FiObject >> resetCachedHash [

	cachedHash := nil
]

{ #category : #accessing }
FiObject >> stepCount [
	
	^ self steps size
]

{ #category : #accessing }
FiObject >> steps [

	| result |
	result := Set new.

	self stepsAndValuesDo: [ :step :value |
		result add: step ].

	^ result
]

{ #category : #enumerating }
FiObject >> stepsAndValues [

	| result |
	result := Set new.

	self stepsAndValuesDo: [ :step :value |
		result add: step -> value ].

	^ result
]

{ #category : #enumerating }
FiObject >> stepsAndValuesDo: aBlockClosure [ 

	^ self subclassResponsibility 
]

{ #category : #printing }
FiObject >> stonOn: stonWriter [

	stonWriter 
		writeObject: self 
		streamMap: [ :dictionary | 
			self stepsAndValuesDo: [ :step :value | 
				dictionary at: step put: value ] ]
]

{ #category : #storing }
FiObject >> storeOn: aStream [

	self storeOn: aStream indent: 1
]

{ #category : #printing }
FiObject >> storeOn: aStream indent: level [

	self subclassResponsibility 
]

{ #category : #comparing }
FiObject >> uncachedHash [
	
	| hash |
	hash := self class hash.
	
	self stepsAndValuesDo: [ :step :value | 
		hash := (hash bitXor: step hash) bitXor: value hash ].
		
	^ hash
]

{ #category : #accessing }
FiObject >> valueAt: step [

	^ self 
		valueAt: step 
		ifPresent: [ :shot | shot ]
		ifAbsent: [ StepNotFound signalFor: step in: self ]
]

{ #category : #accessing }
FiObject >> valueAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ self subclassResponsibility 
]

{ #category : #accessing }
FiObject >> values [
	
	^ Array streamContents: [ :stream |
		self valuesDo: [ :each | stream nextPut: each ] ]

]

{ #category : #enumerating }
FiObject >> valuesDo: elementBlock [
	"Evaluates the block on each value of this object"
	
	^ self stepsAndValuesDo: [ :step :value | elementBlock value: value ]
]
