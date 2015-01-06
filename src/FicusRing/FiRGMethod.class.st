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

{ #category : #polymorphism }
FiRGMethod >> allLiterals [

	| allChildren result |
	allChildren := self ast allChildren.
	result := OrderedCollection new.

	result add: self selector.

	(allChildren 
		select: [:node | node isVariable and: [ node isGlobal ]])
		do: [:node | result addIfNotPresent: (self environment bindingOf: node name) ].

	(allChildren 
		select: [:node | node isLiteralNode and: [ node parent isLiteralNode not ]])
		do: [:node | result addIfNotPresent: node value ].
		
	(allChildren 
		select: [:node | node isMessage ])
		do: [:node | result addIfNotPresent: node selector ].

	result add: (self environment bindingOf: self methodClass name).
	
	^ result asArray
]

{ #category : #printing }
FiRGMethod >> asString [
	"Same as a CompiledMethod"

	^ self sourceCode
]

{ #category : #polymorphism }
FiRGMethod >> ast [
	"Answer my AST with semantic analysis. See #parseTree."

	self flag: #todo. "cache in environment?"	
	^ self parseTree doSemanticAnalysisIn: self methodClass
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

{ #category : #polymorphism }
FiRGMethod >> isCompiledMethod [

	^ true
]

{ #category : #polymorphism }
FiRGMethod >> isDisabled: marker [

	^ marker == CompiledMethod disabledMarker
]

{ #category : #polymorphism }
FiRGMethod >> isExplicitlyRequired: marker [

	^ marker == CompiledMethod explicitRequirementMarker
]

{ #category : #polymorphism }
FiRGMethod >> isFromTrait [
	"Return true for methods that have been included from Traits"

	^ self origin isTrait and: [ self origin ~= self methodClass ]
]

{ #category : #polymorphism }
FiRGMethod >> isImplicitlyRequired: marker [

	^ marker == CompiledMethod implicitRequirementMarker
]

{ #category : #polymorphism }
FiRGMethod >> isProvided [
	^ self isProvided: self markerOrNil
]

{ #category : #polymorphism }
FiRGMethod >> isProvided: marker [
	marker ifNil: [^ true].
	^ (self isRequired: marker) not and: [(self isDisabled: marker) not]
]

{ #category : #polymorphism }
FiRGMethod >> isRequired [
	^ self isRequired: self markerOrNil
]

{ #category : #polymorphism }
FiRGMethod >> isRequired: marker [
	marker ifNil: [^ false].
	(self isImplicitlyRequired: marker) ifTrue: [^ true].
	(self isExplicitlyRequired: marker) ifTrue: [^ true]. 
	(self isSubclassResponsibility: marker) ifTrue: [^ true]. 
	^ false
]

{ #category : #polymorphism }
FiRGMethod >> isReturnSelf [

	| statements |
	statements := self parseTree statements.
	
	^ statements size = 1 and: [ 
		statements first isReturn and: [ 
			statements first value isSelf ] ]
]

{ #category : #polymorphism }
FiRGMethod >> isSubclassResponsibility: marker [

	^ marker == CompiledMethod subclassResponsibilityMarker
]

{ #category : #polymorphism }
FiRGMethod >> literals [

	^ self selectAllVariables: [ :each | each isLiteralNode ]
]

{ #category : #lookup }
FiRGMethod >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	^ self methodClass 
		lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure 
]

{ #category : #polymorphism }
FiRGMethod >> markerOrNil [
	
	| statements node |
	statements := self parseTree statements.

	statements size = 1 ifFalse: [ ^ nil ].
	node := statements first value.	
	(node isMessage and: [ node isSelfSend ]) ifFalse: [ ^ nil ].

	^ node selector
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
FiRGMethod >> numArgs [
	
	^ self ast numArgs 
]

{ #category : #polymorphism }
FiRGMethod >> origin [
	
	self flag: #todo. "Support methods from traits!"
	^ self methodClass
]

{ #category : #polymorphism }
FiRGMethod >> package [
	
	^ self origin package
]

{ #category : #polymorphism }
FiRGMethod >> parseTree [
	"Answer my AST (without semantic analysis). See #ast."

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

	^  self selectAllVariables: [ :each | each isInstance ]
]

{ #category : #polymorphism }
FiRGMethod >> refersToLiteral: literal [ 

	| allChildren |
	allChildren := self ast allChildren.

	literal isVariableBinding ifTrue: [ 
		(allChildren anySatisfy: [:node | 
			node isVariable and: [ 
				node isGlobal and: [ 
					node name = literal key ]]]) 
		ifTrue: [ ^ true ] ].

	(allChildren anySatisfy: [:node | 
		node isLiteralNode and: [ 
			node value = literal ]])
		ifTrue: [ ^ true ].
		
	^ allChildren anySatisfy: [:node | 
		node isMessage and: [ 
			node selector = literal ]]
]

{ #category : #private }
FiRGMethod >> selectAllVariables: aBlock [
	
	^ self ast allChildren
		select: [:each | each isVariable and: [ aBlock value: each ]]
		thenCollect: [ :each | each name ]
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
FiRGMethod >> sendsSelector: aSymbol [

	^ self messages includes: aSymbol
]

{ #category : #printing }
FiRGMethod >> shortPrintOn: aStream [

	aStream 
		nextPutAll: self methodClass name;
		nextPutAll: '>>';
		nextPutAll: self selector.	
]

{ #category : #printing }
FiRGMethod >> shortPrintString [

	^ String streamContents: [ :stream |
		self shortPrintOn: stream ]
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
