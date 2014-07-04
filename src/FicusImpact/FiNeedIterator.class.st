Class {
	#name : #FiNeedIterator,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'needs'
	],
	#category : #'FicusImpact-Needs'
}

{ #category : #initialization }
FiNeedIterator >> initialize [

	super initialize.
	
	needs := OrderedCollection new.
]

{ #category : #public }
FiNeedIterator >> needsFor: aRBMethodNode [ 

	needs := OrderedCollection new.

	aRBMethodNode parseTree doSemanticAnalysis acceptVisitor: self.
	
	^ needs asArray
]

{ #category : #'as yet unclassified' }
FiNeedIterator >> visitMessageNode: aMessageNode [

	| receiver |
	receiver := FiMessageReceiverBuilder new messageReceiverFor: aMessageNode receiver.

	needs add: 
		(FiMessageSend builder
			selector: aMessageNode selector;
			receiver: receiver;
			new).

	super visitMessageNode: aMessageNode.
]

{ #category : #'as yet unclassified' }
FiNeedIterator >> visitVariableNode: aVariableNode [

	aVariableNode isInstance ifTrue: [
		needs add: 
			(FiVariableAccess builder
				variableName: aVariableNode name;
				new) ].

	super visitVariableNode: aVariableNode.
]
