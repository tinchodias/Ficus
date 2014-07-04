Class {
	#name : #FiDependenciesCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'dependencies'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
FiDependenciesCollector >> dependenciesFor: aRBMethodNode [ 

	dependencies := OrderedCollection new.

	aRBMethodNode parseTree doSemanticAnalysis acceptVisitor: self.
	
	^ dependencies asArray
]

{ #category : #initialization }
FiDependenciesCollector >> initialize [

	super initialize.
	
	dependencies := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
FiDependenciesCollector >> visitMessageNode: aMessageNode [

	| receiver |
	receiver := FiMessageReceiverFactory new messageReceiverFor: aMessageNode receiver.

	dependencies add: 
		(FiMessageSend builder
			selector: aMessageNode selector;
			receiver: receiver;
			new).

	super visitMessageNode: aMessageNode.
]

{ #category : #'as yet unclassified' }
FiDependenciesCollector >> visitVariableNode: aVariableNode [

	| binding |
	binding := aVariableNode binding.

	(binding isUndeclared or: [ binding isInstance ]) ifTrue: [
		dependencies add: 
			(FiVariableAccess builder
				variableName: aVariableNode name;
				new) ].

	super visitVariableNode: aVariableNode.
]
