Class {
	#name : #RFiLMethodVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'collector'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #accessing }
RFiLMethodVisitor >> collector [
	^ collector
]

{ #category : #accessing }
RFiLMethodVisitor >> collector: anObject [
	collector := anObject
]

{ #category : #public }
RFiLMethodVisitor >> messageReceiverFor: aRBNode [ 

	aRBNode isSelf ifTrue: [ 
		^ RFiSelfMessageReceiver defaultInstance ].

	aRBNode isSuper ifTrue: [ 
		^ RFiSuperMessageReceiver defaultInstance ].
	
	^ RFiAnyMessageReceiver defaultInstance
]

{ #category : #visitor }
RFiLMethodVisitor >> visitArgumentNode: anArgumentNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
RFiLMethodVisitor >> visitMessageNode: aMessageNode [

	| receiver |
	receiver := self messageReceiverFor: aMessageNode receiver.

	collector messageSendTo: receiver of: aMessageNode selector.

	super visitMessageNode: aMessageNode.
]

{ #category : #public }
RFiLMethodVisitor >> visitMethod: aRFiMethod [ 

	^ aRFiMethod parseTree acceptVisitor: self

]

{ #category : #visitor }
RFiLMethodVisitor >> visitSelfNode: aSelfNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
RFiLMethodVisitor >> visitSuperNode: aSuperNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
RFiLMethodVisitor >> visitTemporaryNode: aNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
RFiLMethodVisitor >> visitThisContextNode: aThisContextNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
RFiLMethodVisitor >> visitVariableNode: aVariableNode [

	collector variableAccess: aVariableNode name
]
