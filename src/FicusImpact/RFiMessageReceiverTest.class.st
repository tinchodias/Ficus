"
A FiMessageReceiverBuilderTest is a test class for testing the behavior of FiMessageReceiverBuilder
"
Class {
	#name : #RFiMessageReceiverTest,
	#superclass : #TestCase,
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
RFiMessageReceiverTest >> assertMessageReceiverOf: sourceCodeFragment equals: aMessageReceiver [
	
	| node |
	node := self receiverNodeFor: sourceCodeFragment.
	
	self 
		assert: (RFiMethodRequisiteCollector new messageReceiverFor: node) 
		equals: aMessageReceiver 
]

{ #category : #private }
RFiMessageReceiverTest >> astOf: sourceCode [

	^ RBParser parseMethod: sourceCode
]

{ #category : #private }
RFiMessageReceiverTest >> receiverNodeFor: sourceCodeFragment [

	| ast |
	ast := self astOf: 'method: arg1 ', sourceCodeFragment.
	
	self assert: ast body isSequence. 
	self assert: ast body statements size equals: 1. 
	self assert: ast body statements anyOne isMessage.

	^ ast body statements anyOne receiver
]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver1 [

	self 
		assertMessageReceiverOf: 'a1 hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver10 [

	self 
		assertMessageReceiverOf: '(a1 := true) hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver11 [

	self 
		assertMessageReceiverOf: 'Object hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver12 [

	self 
		assertMessageReceiverOf: 'arg1 hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver2 [

	self 
		assertMessageReceiverOf: '1 hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver3 [

	self 
		assertMessageReceiverOf: 'thisContext hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver4 [

	self 
		assertMessageReceiverOf: '(1 + 2) hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver5 [

	self 
		assertMessageReceiverOf: '(Object new; yourself) hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver6 [

	self 
		assertMessageReceiverOf: '| tmp | tmp hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver7 [

	self 
		assertMessageReceiverOf: '{1. 2.} hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver8 [

	self 
		assertMessageReceiverOf: '#(1 2) hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testAnyMessageReceiver9 [

	self 
		assertMessageReceiverOf: '#[1 2] hash' 
		equals: RFiAnyMessageReceiver new


]

{ #category : #tests }
RFiMessageReceiverTest >> testSelfMessageReceiver [

	self 
		assertMessageReceiverOf: 'self hash' 
		equals: RFiSelfMessageReceiver new

]

{ #category : #tests }
RFiMessageReceiverTest >> testSuperMessageReceiver [

	self 
		assertMessageReceiverOf: 'super hash' 
		equals: RFiSuperMessageReceiver new

]
