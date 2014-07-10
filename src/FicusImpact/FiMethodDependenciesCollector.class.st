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

	aRBMethodNode parseTree doSemanticAnalysis acceptVisitor: self.
	
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

	| binding |
	binding := aVariableNode binding.

	((binding isUndeclared or: [ binding isInstance ]) or: [ binding isGlobal ]) ifTrue: [
		dependencies add: 
			(FiVariableAccess builder
				variableName: aVariableNode name;
				new) ].

	super visitVariableNode: aVariableNode.
]
