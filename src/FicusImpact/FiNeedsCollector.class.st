Class {
	#name : #FiNeedsCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'needs'
	],
	#category : #'FicusImpact-Needs'
}

{ #category : #initialization }
FiNeedsCollector >> initialize [

	super initialize.
	
	needs := OrderedCollection new.
]

{ #category : #public }
FiNeedsCollector >> needsFor: aRBMethodNode [ 

	needs := OrderedCollection new.

	aRBMethodNode parseTree doSemanticAnalysis acceptVisitor: self.
	
	^ needs asArray
]

{ #category : #'as yet unclassified' }
FiNeedsCollector >> visitMessageNode: aMessageNode [

	| receiver |
	receiver := FiMessageReceiverFactory new messageReceiverFor: aMessageNode receiver.

	needs add: 
		(FiMessageSend builder
			selector: aMessageNode selector;
			receiver: receiver;
			new).

	super visitMessageNode: aMessageNode.
]

{ #category : #'as yet unclassified' }
FiNeedsCollector >> visitVariableNode: aVariableNode [

	| binding |
	binding := aVariableNode binding.

	(binding isUndeclared or: [ binding isInstance ]) ifTrue: [
		needs add: 
			(FiVariableAccess builder
				variableName: aVariableNode name;
				new) ].

	super visitVariableNode: aVariableNode.
]
