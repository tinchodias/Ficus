"
I am polymorphic with CompilerMethod, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGMethod,
	#superclass : #FiRGObject,
	#instVars : [
		'methodShot',
		'methodClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #comparing }
FiRGMethod >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self methodClass = other methodClass 
		and: [ methodShot = other methodShot ]
]

{ #category : #printing }
FiRGMethod >> asString [
	"Same as a CompiledMethod"

	^ self sourceCode
]

{ #category : #polymorphism }
FiRGMethod >> ast [
	
	^ self parseTree
]

{ #category : #polymorphism }
FiRGMethod >> environment [
	
	^ methodClass environment
]

{ #category : #comparing }
FiRGMethod >> hash [

	^ (self class hash 
		bitXor: methodClass hash)
		bitXor: methodShot hash
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
	
	^ methodClass
]

{ #category : #polymorphism }
FiRGMethod >> methodClass: anObject [
	
	methodClass := anObject
]

{ #category : #accessing }
FiRGMethod >> methodShot [
	
	^ methodShot
]

{ #category : #accessing }
FiRGMethod >> methodShot: anObject [
	
	methodShot := anObject
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

{ #category : #polymorphism }
FiRGMethod >> protocol [
	
	^ methodShot protocol
]

{ #category : #polymorphism }
FiRGMethod >> referredInstVars [

	| tree allChildren |
	self flag: #todo. "fix:this is not precise"
	
	tree := self parseTree.
	allChildren := tree allChildren.
	
	^ (allChildren select: #isVariable) collect: [ :each | each name ]
]

{ #category : #polymorphism }
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

{ #category : #polymorphism }
FiRGMethod >> selector [

	^ methodShot selector
]

{ #category : #polymorphism }
FiRGMethod >> selfMessages [

	| selfMessages searcher |
	selfMessages := Set new.
	searcher := RBParseTreeSearcher new.
	searcher
		matches: 'self `@message: ``@args'
			do: [:aNode :answer | selfMessages add: aNode selector].

	searcher executeTree: self parseTree initialAnswer: nil.
	
	^ selfMessages
]

{ #category : #polymorphism }
FiRGMethod >> sourceCode [

	^ methodShot sourceCode
]

{ #category : #polymorphism }
FiRGMethod >> superMessages [

	| superMessages searcher |
	superMessages := Set new.
	searcher := RBParseTreeSearcher new.
	searcher
		matches: 'super `@message: ``@args'
			do: [:aNode :answer | superMessages add: aNode selector].

	searcher executeTree: self parseTree initialAnswer: nil.
	
	^ superMessages
]
