"
I am polymorphic with CompilerMethod, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGMethod,
	#superclass : #FiRGShot,
	#instVars : [
		'shot',
		'ringEnvironment',
		'ringMethodClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #comparing }
FiRGMethod >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self environment = other environment 
		and: [ self shot = other shot ]
]

{ #category : #polymorphism }
FiRGMethod >> environment [
	
	^ ringEnvironment
]

{ #category : #comparing }
FiRGMethod >> hash [

	^ (self class hash 
		bitXor: self environment hash)
		bitXor: self shot hash
]

{ #category : #lookup }
FiRGMethod >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	^ self methodClass 
		lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure 
]

{ #category : #polymorphism }
FiRGMethod >> messages [

	^ FiSentSelectorsCollector new
		in: [ :visitor | self parseTree acceptVisitor: visitor ];
		selectors.

]

{ #category : #polymorphism }
FiRGMethod >> methodClass [
	
	^ ringMethodClass
]

{ #category : #polymorphism }
FiRGMethod >> parseTree [

	^(RBExplicitVariableParser 
		parseMethod: self sourceCode 
		onError: [ :msg :pos | ^ nil ]) methodClass: self methodClass.
	
]

{ #category : #printing }
FiRGMethod >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self methodClass name;
		nextPutAll: '>>';
		nextPutAll: self selector;
		nextPut: $).
	
]

{ #category : #accessing }
FiRGMethod >> ringEnvironment: anObject [
	
	ringEnvironment := anObject
]

{ #category : #accessing }
FiRGMethod >> ringMethodClass: anObject [
	
	ringMethodClass := anObject
]

{ #category : #polymorphism }
FiRGMethod >> selector [

	^ shot selector
]

{ #category : #accessing }
FiRGMethod >> shot [
	
	^ shot
]

{ #category : #accessing }
FiRGMethod >> shot: anObject [
	
	shot := anObject
]

{ #category : #polymorphism }
FiRGMethod >> sourceCode [

	^ shot sourceCode
]
