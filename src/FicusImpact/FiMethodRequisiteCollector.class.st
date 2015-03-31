Class {
	#name : #FiMethodRequisiteCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'dependencies'
	],
	#category : #'FicusImpact-Requisites'
}

{ #category : #public }
FiMethodRequisiteCollector >> messageReceiverFor: aRBNode [ 

	aRBNode isSelf ifTrue: [ 
		^ FiSelfMessageReceiver defaultInstance ].

	aRBNode isSuper ifTrue: [ 
		^ FiSuperMessageReceiver defaultInstance ].
	
	^ FiAnyMessageReceiver defaultInstance
]

{ #category : #public }
FiMethodRequisiteCollector >> requisitesFor: aFiRGMethod [ 

	dependencies := OrderedCollection new.
	
	aFiRGMethod parseTree acceptVisitor: self.
	
	^ dependencies
]

{ #category : #visitor }
FiMethodRequisiteCollector >> visitMessageNode: aMessageNode [

	| receiver |
	receiver := self messageReceiverFor: aMessageNode receiver.

	dependencies add: 
		(FiMessageSend builder
			selector: aMessageNode selector;
			receiver: receiver;
			new).

	super visitMessageNode: aMessageNode.
]

{ #category : #visitor }
FiMethodRequisiteCollector >> visitVariableNode: aVariableNode [

	"This means that it is not any an argument, nor temporaty, nor self, nor super, etc."
	aVariableNode class == RBVariableNode ifTrue: [
		dependencies add: 
			(FiVariableAccess builder
				variableName: aVariableNode name;
				new) ].

	super visitVariableNode: aVariableNode.
]
