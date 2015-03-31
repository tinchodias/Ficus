Class {
	#name : #FiLMethodVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'collector'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #accessing }
FiLMethodVisitor >> collector [
	^ collector
]

{ #category : #accessing }
FiLMethodVisitor >> collector: anObject [
	collector := anObject
]

{ #category : #public }
FiLMethodVisitor >> messageReceiverFor: aRBNode [ 

	aRBNode isSelf ifTrue: [ 
		^ FiSelfMessageReceiver defaultInstance ].

	aRBNode isSuper ifTrue: [ 
		^ FiSuperMessageReceiver defaultInstance ].
	
	^ FiAnyMessageReceiver defaultInstance
]

{ #category : #visitor }
FiLMethodVisitor >> visitArgumentNode: anArgumentNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
FiLMethodVisitor >> visitMessageNode: aMessageNode [

	| receiver |
	receiver := self messageReceiverFor: aMessageNode receiver.

	collector messageSendTo: receiver of: aMessageNode selector.

	super visitMessageNode: aMessageNode.
]

{ #category : #public }
FiLMethodVisitor >> visitMethod: aFiRGMethod [ 

	^ aFiRGMethod parseTree acceptVisitor: self

]

{ #category : #visitor }
FiLMethodVisitor >> visitSelfNode: aSelfNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
FiLMethodVisitor >> visitSuperNode: aSuperNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
FiLMethodVisitor >> visitTemporaryNode: aNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
FiLMethodVisitor >> visitThisContextNode: aThisContextNode [
	"We're only interested in accesses to variables that are external to the method."
]

{ #category : #visitor }
FiLMethodVisitor >> visitVariableNode: aVariableNode [

	collector variableAccess: aVariableNode name
]
