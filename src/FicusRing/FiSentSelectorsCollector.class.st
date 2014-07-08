Class {
	#name : #FiSentSelectorsCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'selectors'
	],
	#category : #'FicusRing-AST'
}

{ #category : #initialization }
FiSentSelectorsCollector >> initialize [

	super initialize.
	
	selectors := IdentitySet new.
]

{ #category : #accessing }
FiSentSelectorsCollector >> selectors [
	
	^ selectors
]

{ #category : #visitor }
FiSentSelectorsCollector >> visitMessageNode: aMessageNode [

	selectors add: aMessageNode selector.
	
	super visitMessageNode: aMessageNode.
]
