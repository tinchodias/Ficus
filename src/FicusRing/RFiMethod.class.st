"
I am polymorphic with CompilerMethod, fetching everything needed from a Ficus environment.
"
Class {
	#name : #RFiMethod,
	#superclass : #RFiObject,
	#instVars : [
		'methodClass',
		'cachedAst',
		'ficusMethod'
	],
	#category : #'FicusRing-Core'
}

{ #category : #'instance creation' }
RFiMethod class >> methodClass: aRFiBehavior ficusMethod: aFiMethod [

	^ self basicNew
		initializeWithMethodClass: aRFiBehavior 
		ficusMethod: aFiMethod;
		yourself
]

{ #category : #comparing }
RFiMethod >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self methodClass = other methodClass 
		and: [ ficusMethod = other ficusMethod ]
]

{ #category : #polymorphism }
RFiMethod >> allLiterals [

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

{ #category : #converting }
RFiMethod >> asActiveRingDefinition [

	^ RGMethodDefinition new 
			name: self selector;
			parentName: self methodClass name;
			isMetaSide: self methodClass isMeta;
			asActive.

]

{ #category : #printing }
RFiMethod >> asString [
	"Same as a CompiledMethod"

	^ self sourceCode
]

{ #category : #polymorphism }
RFiMethod >> ast [
	"Answer my AST with semantic analysis. See #parseTree."

	^ cachedAst ifNil: [
		cachedAst := self parseTree doSemanticAnalysisIn: self methodClass ]
]

{ #category : #printing }
RFiMethod >> definition [
	"Polymorphic to class definition"
	
	^ self sourceCode
]

{ #category : #polymorphism }
RFiMethod >> environment [
	
	^ methodClass environment
]

{ #category : #accessing }
RFiMethod >> ficusMethod [
	
	^ ficusMethod
]

{ #category : #accessing }
RFiMethod >> ficusPathFromEnvironment [

	^ self environment ficusPathToMethod: self
]

{ #category : #comparing }
RFiMethod >> hash [

	^ (self class hash 
		bitXor: methodClass hash)
		bitXor: ficusMethod hash
]

{ #category : #initialization }
RFiMethod >> initializeWithMethodClass: aRFiClass ficusMethod: aFiMethod [
	
	self initialize.

	methodClass := aRFiClass.
	ficusMethod := aFiMethod.
]

{ #category : #polymorphism }
RFiMethod >> isCompiledMethod [

	^ true
]

{ #category : #polymorphism }
RFiMethod >> isDisabled: marker [

	^ marker == CompiledMethod disabledMarker
]

{ #category : #polymorphism }
RFiMethod >> isExplicitlyRequired: marker [

	^ marker == CompiledMethod explicitRequirementMarker
]

{ #category : #polymorphism }
RFiMethod >> isFromTrait [
	"Return true for methods that have been included from Traits"

	^ self origin isTrait and: [ self origin ~= self methodClass ]
]

{ #category : #polymorphism }
RFiMethod >> isImplicitlyRequired: marker [

	^ marker == CompiledMethod implicitRequirementMarker
]

{ #category : #polymorphism }
RFiMethod >> isProvided [
	^ self isProvided: self markerOrNil
]

{ #category : #polymorphism }
RFiMethod >> isProvided: marker [
	marker ifNil: [^ true].
	^ (self isRequired: marker) not and: [(self isDisabled: marker) not]
]

{ #category : #polymorphism }
RFiMethod >> isRequired [
	^ self isRequired: self markerOrNil
]

{ #category : #polymorphism }
RFiMethod >> isRequired: marker [
	marker ifNil: [^ false].
	(self isImplicitlyRequired: marker) ifTrue: [^ true].
	(self isExplicitlyRequired: marker) ifTrue: [^ true]. 
	(self isSubclassResponsibility: marker) ifTrue: [^ true]. 
	^ false
]

{ #category : #polymorphism }
RFiMethod >> isReturnSelf [

	| statements |
	statements := self parseTree statements.
	
	^ statements isEmpty or: [
		statements size = 1 and: [ 
		statements first isReturn and: [ 
		statements first value isSelf ]]]
]

{ #category : #polymorphism }
RFiMethod >> isSubclassResponsibility: marker [

	^ marker == CompiledMethod subclassResponsibilityMarker
]

{ #category : #polymorphism }
RFiMethod >> literals [

	^ self allLiterals
]

{ #category : #lookup }
RFiMethod >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	^ self methodClass 
		lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure 
]

{ #category : #polymorphism }
RFiMethod >> markerOrNil [
	
	| statements node |
	statements := self parseTree statements.

	statements size = 1 ifFalse: [ ^ nil ].
	node := statements first value.	
	(node isMessage and: [ node isSelfSend ]) ifFalse: [ ^ nil ].

	^ node selector
]

{ #category : #polymorphism }
RFiMethod >> messages [

	^ self parseTree sentMessages
]

{ #category : #polymorphism }
RFiMethod >> methodClass [
	
	^ methodClass
]

{ #category : #polymorphism }
RFiMethod >> methodClass: anObject [
	
	methodClass := anObject
]

{ #category : #polymorphism }
RFiMethod >> numArgs [
	
	^ self ast numArgs 
]

{ #category : #polymorphism }
RFiMethod >> origin [
	
	self flag: #todo. "Support methods from traits!"
	^ self methodClass
]

{ #category : #polymorphism }
RFiMethod >> package [
	
	^ self origin package
]

{ #category : #polymorphism }
RFiMethod >> parseTree [
	"Answer my AST, without semantic analysis, unless it's anlready cached. See #ast."

	cachedAst ifNotNil: [ ^ cachedAst ].

	^(RBParser 
		parseMethod: self sourceCode 
		onError: [ :msg :pos | ^ nil ]) methodClass: self methodClass.

]

{ #category : #polymorphism }
RFiMethod >> pragmas [

	^ self parseTree pragmas
]

{ #category : #printing }
RFiMethod >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self methodClass name;
		nextPutAll: '>>';
		nextPutAll: self selector;
		nextPut: $).
	
]

{ #category : #polymorphism }
RFiMethod >> protocol [
	
	^ ficusMethod protocol
]

{ #category : #polymorphism }
RFiMethod >> referredInstVars [

	^  self selectAllVariables: [ :each | each isInstance ]
]

{ #category : #polymorphism }
RFiMethod >> refersToLiteral: literal [ 

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
RFiMethod >> selectAllVariables: aBlock [
	
	^ self ast allChildren
		select: [:each | each isVariable and: [ aBlock value: each ]]
		thenCollect: [ :each | each name ]
]

{ #category : #polymorphism }
RFiMethod >> selector [

	^ ficusMethod selector
]

{ #category : #polymorphism }
RFiMethod >> selfMessages [

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
RFiMethod >> sendsSelector: aSymbol [

	^ self messages includes: aSymbol
]

{ #category : #printing }
RFiMethod >> shortPrintOn: aStream [

	aStream 
		nextPutAll: self methodClass name;
		nextPutAll: '>>';
		nextPutAll: self selector.	
]

{ #category : #printing }
RFiMethod >> shortPrintString [

	^ String streamContents: [ :stream |
		self shortPrintOn: stream ]
]

{ #category : #polymorphism }
RFiMethod >> sourceCode [

	^ ficusMethod sourceCode
]

{ #category : #polymorphism }
RFiMethod >> superMessages [

	| superMessages searcher |
	superMessages := Set new.
	searcher := RBParseTreeSearcher new.
	searcher
		matches: 'super `@message: ``@args'
			do: [:aNode :answer | superMessages add: aNode selector].

	searcher executeTree: self parseTree initialAnswer: nil.
	
	^ superMessages
]
