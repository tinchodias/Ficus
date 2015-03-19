"
I represent an abstract score of a FiComment.
"
Class {
	#name : #FiCommentScore,
	#superclass : #FiFixedObject,
	#category : #'FicusStore-Comments-Model'
}

{ #category : #inspecting }
FiCommentScore >> ficusInspectorIcon [
	
	^ self prettyPrintString asMorph
]

{ #category : #printing }
FiCommentScore >> prettyPrintString [

	^ self subclassResponsibility 
]
