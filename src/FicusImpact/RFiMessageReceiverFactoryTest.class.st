"
A FiMessageReceiverBuilderTest is a test class for testing the behavior of FiMessageReceiverBuilder
"
Class {
	#name : #RFiMessageReceiverFactoryTest,
	#superclass : #TestCase,
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
RFiMessageReceiverFactoryTest >> assertMessageReceiverOf: sourceCodeFragment equals: aMessageReceiver [
	
	| node |
	node := self receiverNodeFor: sourceCodeFragment.
	
	self 
		assert: (RFiMethodRequisiteCollector new messageReceiverFor: node) 
		equals: aMessageReceiver 
]

{ #category : #private }
RFiMessageReceiverFactoryTest >> astOf: sourceCode [

	^ RBExplicitVariableParser parseMethod: sourceCode
]

{ #category : #private }
RFiMessageReceiverFactoryTest >> receiverNodeFor: sourceCodeFragment [

	| ast |
	ast := self astOf: 'method: arg1 ', sourceCodeFragment.
	
	self assert: ast body isSequence. 
	self assert: ast body statements size equals: 1. 
	self assert: ast body statements anyOne isMessage.

	^ ast body statements anyOne receiver
]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver1 [

	self 
		assertMessageReceiverOf: 'a1 hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver10 [

	self 
		assertMessageReceiverOf: '(a1 := true) hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver11 [

	self 
		assertMessageReceiverOf: 'Object hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver12 [

	self 
		assertMessageReceiverOf: 'arg1 hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver2 [

	self 
		assertMessageReceiverOf: '1 hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver3 [

	self 
		assertMessageReceiverOf: 'thisContext hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver4 [

	self 
		assertMessageReceiverOf: '(1 + 2) hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver5 [

	self 
		assertMessageReceiverOf: '(Object new; yourself) hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver6 [

	self 
		assertMessageReceiverOf: '| tmp | tmp hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver7 [

	self 
		assertMessageReceiverOf: '{1. 2.} hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver8 [

	self 
		assertMessageReceiverOf: '#(1 2) hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testAnyMessageReceiver9 [

	self 
		assertMessageReceiverOf: '#[1 2] hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testSelfMessageReceiver [

	self 
		assertMessageReceiverOf: 'self hash' 
		equals: RFiSelfMessageReceiver new

]

{ #category : #tests }
RFiMessageReceiverFactoryTest >> testSuperMessageReceiver [

	self 
		assertMessageReceiverOf: 'super hash' 
		equals: RFiSuperMessageReceiver new

]
