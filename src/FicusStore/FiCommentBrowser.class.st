Class {
	#name : #FiCommentBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'commentsTreeModel'
	],
	#category : #'FicusStore-HistoryNodes'
}

{ #category : #specs }
FiCommentBrowser class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		add: #commentsTreeModel;
		yourself
]

{ #category : #example }
FiCommentBrowser class >> example [
	"
	self example
	"

	| someComments |
	someComments := { 
		FiComment builder 
			target: nil;
			contents: 'I like it';
			new.
		FiComment builder 
			target: nil;
			contents: 'It should be improved';
			new }.

	^ self new
		comments: someComments;
		openWithSpec;
		yourself
]

{ #category : #accessing }
FiCommentBrowser >> comments: someComments [

	commentsTreeModel roots: someComments 
]

{ #category : #accessing }
FiCommentBrowser >> commentsTreeModel [

	^ commentsTreeModel
]

{ #category : #initialization }
FiCommentBrowser >> initializePresenter [

	super initializePresenter.

	commentsTreeModel 
		displayBlock: [ :aComment | self morphFor: aComment ]	

]

{ #category : #initialization }
FiCommentBrowser >> initializeWidgets [

	self instantiateModels: #(
		commentsTreeModel TreeModel).

]

{ #category : #private }
FiCommentBrowser >> morphFor: aComment [

	^ aComment contents asText asMorph
]
