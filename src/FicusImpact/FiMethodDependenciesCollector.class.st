Class {
	#name : #FiMethodDependenciesCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'dependencies'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
FiMethodDependenciesCollector >> dependenciesFor: aFiRGMethod [ 

	dependencies := OrderedCollection new.

	aFiRGMethod parseTree acceptVisitor: self.
	
	^ dependencies asArray
]

{ #category : #public }
FiMethodDependenciesCollector >> messageReceiverFor: aRBNode [ 

	aRBNode isSelf ifTrue: [ 
		^ FiSelfMessageReceiver new ].

	aRBNode isSuper ifTrue: [ 
		^ FiSuperMessageReceiver new ].
	
	^ FiAnyMessageReceiver new
]

{ #category : #visitor }
FiMethodDependenciesCollector >> visitMessageNode: aMessageNode [

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
FiMethodDependenciesCollector >> visitVariableNode: aVariableNode [

	"This means that it is not any an argument, nor temporaty, nor self, nor super, etc."
	aVariableNode class == RBVariableNode ifTrue: [
		dependencies add: 
			(FiVariableAccess builder
				variableName: aVariableNode name;
				new) ].

	super visitVariableNode: aVariableNode.
]
