"
A FiMessageReceiverBuilderTest is a test class for testing the behavior of FiMessageReceiverBuilder
"
Class {
	#name : #FiMessageReceiverBuilderTest,
	#superclass : #TestCase,
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiMessageReceiverBuilderTest >> assertMessageReceiverOf: sourceCodeFragment equals: aMessageReceiver [
	
	| node |
	node := self receiverNodeFor: sourceCodeFragment.
	
	self assert: (FiMessageReceiverBuilder new messageReceiverFor: node) equals: aMessageReceiver 
]

{ #category : #private }
FiMessageReceiverBuilderTest >> astOf: sourceCode [

	^ RBExplicitVariableParser parseMethod: sourceCode
]

{ #category : #private }
FiMessageReceiverBuilderTest >> receiverNodeFor: sourceCodeFragment [

	| ast |
	ast := self astOf: 'method: arg1 ', sourceCodeFragment.
	
	self assert: ast body isSequence. 
	self assert: ast body statements size equals: 1. 
	self assert: ast body statements anyOne isMessage.

	^ ast body statements anyOne receiver
]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver1 [

	self 
		assertMessageReceiverOf: 'a1 hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver10 [

	self 
		assertMessageReceiverOf: '(a1 := true) hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver11 [

	self 
		assertMessageReceiverOf: 'Object hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver12 [

	self 
		assertMessageReceiverOf: 'arg1 hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver2 [

	self 
		assertMessageReceiverOf: '1 hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver3 [

	self 
		assertMessageReceiverOf: 'thisContext hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver4 [

	self 
		assertMessageReceiverOf: '(1 + 2) hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver5 [

	self 
		assertMessageReceiverOf: '(Object new; yourself) hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver6 [

	self 
		assertMessageReceiverOf: '| tmp | tmp hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver7 [

	self 
		assertMessageReceiverOf: '{1. 2.} hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver8 [

	self 
		assertMessageReceiverOf: '#(1 2) hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testAnyMessageReceiver9 [

	self 
		assertMessageReceiverOf: '#[1 2] hash' 
		equals: FiAnyMessageReceiver new


]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testSelfMessageReceiver [

	self 
		assertMessageReceiverOf: 'self hash' 
		equals: FiSelfMessageReceiver new

]

{ #category : #tests }
FiMessageReceiverBuilderTest >> testSuperMessageReceiver [

	self 
		assertMessageReceiverOf: 'super hash' 
		equals: FiSuperMessageReceiver new

]
