"
I am polymorphic with CompilerMethod, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGMethod,
	#superclass : #FiRGShot,
	#instVars : [
		'shot',
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
	
	^ ringMethodClass environment
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

	^ self parseTree sentMessages
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

{ #category : #polymorphism }
FiRGMethod >> pragmas [

	^ self parseTree pragmas
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

{ #category : #'as yet unclassified' }
FiRGMethod >> protocol [
	
	^ shot protocol
]

{ #category : #'as yet unclassified' }
FiRGMethod >> referredInstVars [

	| tree allChildren |
	self flag: #todo. "fix:this is not precise"
	
	tree := self parseTree.
	allChildren := tree allChildren.
	
	^ (allChildren select: #isVariable) collect: [ :each | each name ]
]

{ #category : #'as yet unclassified' }
FiRGMethod >> refersToLiteral: literal [ 

	| tree allChildren |
	self flag: #todo. "fix:this is not precise"
	
	tree := self parseTree.
	allChildren := tree allChildren.
	
	^ literal isSymbol 
		ifFalse: [ "Then, an association" 
			(allChildren select: #isVariable) anySatisfy: [ :each | each name = literal key ] ]
		ifTrue: [
			tree sentMessages includes: literal.
			"(allChildren select: #isLiteralNode) anySatisfy: [ :each | each value = literal ]" ]
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
