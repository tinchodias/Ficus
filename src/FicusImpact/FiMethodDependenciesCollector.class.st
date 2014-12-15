Class {
	#name : #FiMethodDependenciesCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'dependencies'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
FiMethodDependenciesCollector >> dependenciesFor: aRBMethodNode [ 

	dependencies := OrderedCollection new.

	aRBMethodNode parseTree acceptVisitor: self.
	
	^ dependencies asArray
]

{ #category : #initialization }
FiMethodDependenciesCollector >> initialize [

	super initialize.
	
	dependencies := OrderedCollection new.
]

{ #category : #visitor }
FiMethodDependenciesCollector >> visitMessageNode: aMessageNode [

	| receiver |
	receiver := FiMessageReceiverFactory new messageReceiverFor: aMessageNode receiver.

	dependencies add: 
		(FiMessageSend builder
			selector: aMessageNode selector;
			receiver: receiver;
			new).

	super visitMessageNode: aMessageNode.
]

{ #category : #visitor }
FiMethodDependenciesCollector >> visitVariableNode: aVariableNode [

	(aVariableNode isArgument or: [ 
		aVariableNode isSelf or: [ 
			aVariableNode isSuper ] ]) ifFalse: [
		dependencies add: 
			(FiVariableAccess builder
				variableName: aVariableNode name;
				new) ].

	super visitVariableNode: aVariableNode.
]
