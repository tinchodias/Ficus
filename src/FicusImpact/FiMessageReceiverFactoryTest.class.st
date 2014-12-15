"
A FiMessageReceiverBuilderTest is a test class for testing the behavior of FiMessageReceiverBuilder
"
Class {
	#name : #FiMessageReceiverFactoryTest,
	#superclass : #TestCase,
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiMessageReceiverFactoryTest >> assertMessageReceiverOf: sourceCodeFragment equals: aMessageReceiver [
	
	| node |
	node := self receiverNodeFor: sourceCodeFragment.
	
	self 
		assert: (FiMethodDependenciesCollector new messageReceiverFor: node) 
		equals: aMessageReceiver 
]

{ #category : #private }
FiMessageReceiverFactoryTest >> astOf: sourceCode [

	^ RBExplicitVariableParser parseMethod: sourceCode
]

{ #category : #private }
FiMessageReceiverFactoryTest >> receiverNodeFor: sourceCodeFragment [

	| ast |
	ast := self astOf: 'method: arg1 ', sourceCodeFragment.
	
	self assert: ast body isSequence. 
	self assert: ast body statements size equals: 1. 
	self assert: ast body statements anyOne isMessage.

	^ ast body statements anyOne receiver
]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver1 [

	self 
		assertMessageReceiverOf: 'a1 hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver10 [

	self 
		assertMessageReceiverOf: '(a1 := true) hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver11 [

	self 
		assertMessageReceiverOf: 'Object hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver12 [

	self 
		assertMessageReceiverOf: 'arg1 hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver2 [

	self 
		assertMessageReceiverOf: '1 hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver3 [

	self 
		assertMessageReceiverOf: 'thisContext hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver4 [

	self 
		assertMessageReceiverOf: '(1 + 2) hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver5 [

	self 
		assertMessageReceiverOf: '(Object new; yourself) hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver6 [

	self 
		assertMessageReceiverOf: '| tmp | tmp hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver7 [

	self 
		assertMessageReceiverOf: '{1. 2.} hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver8 [

	self 
		assertMessageReceiverOf: '#(1 2) hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testAnyMessageReceiver9 [

	self 
		assertMessageReceiverOf: '#[1 2] hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testSelfMessageReceiver [

	self 
		assertMessageReceiverOf: 'self hash' 
		equals: FiSelfMessageReceiver new

]

{ #category : #tests }
FiMessageReceiverFactoryTest >> testSuperMessageReceiver [

	self 
		assertMessageReceiverOf: 'super hash' 
		equals: FiSuperMessageReceiver new

]
