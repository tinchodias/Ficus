Class {
	#name : #FiMethodMessagesCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'selectors'
	],
	#category : #'FicusRing-AST'
}

{ #category : #initialization }
FiMethodMessagesCollector >> initialize [

	super initialize.
	
	selectors := IdentitySet new.
]

{ #category : #accessing }
FiMethodMessagesCollector >> selectors [
	
	^ selectors
]

{ #category : #visitor }
FiMethodMessagesCollector >> visitMessageNode: aMessageNode [

	selectors add: aMessageNode selector.
	
	super visitMessageNode: aMessageNode.
]
