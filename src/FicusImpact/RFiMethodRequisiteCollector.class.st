Class {
	#name : #RFiMethodRequisiteCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'dependencies'
	],
	#category : #'FicusImpact-Interpreting'
}

{ #category : #public }
RFiMethodRequisiteCollector >> messageReceiverFor: aRBNode [ 

	aRBNode isSelf ifTrue: [ 
		^ RFiSelfMessageReceiver defaultInstance ].

	aRBNode isSuper ifTrue: [ 
		^ RFiSuperMessageReceiver defaultInstance ].
	
	^ RFiAnyMessageReceiver defaultInstance
]

{ #category : #public }
RFiMethodRequisiteCollector >> requisitesFor: aRFiMethod [ 

	dependencies := OrderedCollection new.
	
	aRFiMethod parseTree doSemanticAnalysis acceptVisitor: self.
	
	^ dependencies
]

{ #category : #visitor }
RFiMethodRequisiteCollector >> visitMessageNode: aMessageNode [

	| receiver |
	receiver := self messageReceiverFor: aMessageNode receiver.

	dependencies add: 
		(RFiMessageSend builder
			selector: aMessageNode selector;
			receiver: receiver;
			new).

	super visitMessageNode: aMessageNode.
]

{ #category : #visitor }
RFiMethodRequisiteCollector >> visitVariableNode: aVariableNode [

	"This means that it is not any an argument, nor temporaty, nor self, nor super, etc."
	aVariableNode class == RBVariableNode ifTrue: [
		dependencies add: 
			(RFiVariableAccess builder
				variableName: aVariableNode name;
				new) ].

	super visitVariableNode: aVariableNode.
]
