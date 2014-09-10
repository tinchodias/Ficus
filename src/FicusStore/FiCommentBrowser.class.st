Class {
	#name : #FiCommentBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'commentsTreeModel',
		'plugin'
	],
	#category : #'FicusStore-History-UI'
}

{ #category : #specs }
FiCommentBrowser class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		add: #commentsTreeModel;
		yourself
]

{ #category : #accessing }
FiCommentBrowser >> commentsTreeModel [

	^ commentsTreeModel
]

{ #category : #accessing }
FiCommentBrowser >> historyNodes: aCollectionOfHistoryNodes [

	| comments |
	comments := aCollectionOfHistoryNodes flatCollect: [ :node | plugin commentsFor: node ].

	commentsTreeModel roots: comments.
]

{ #category : #initialization }
FiCommentBrowser >> initializePresenter [

	super initializePresenter.

	self title: 'Ficus Comment Browser'.

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

	^ ((aComment target asString asText 
			addAttribute: (TextFontChange fontNumber: 1); "the smaller one"
			addAttribute: (TextColor color: Color gray);
			yourself), 
			String cr, 
			aComment contents) 
				asText asMorph lock: true; yourself
]

{ #category : #accessing }
FiCommentBrowser >> plugin [

	^ plugin
]

{ #category : #accessing }
FiCommentBrowser >> plugin: aPlugin [

	plugin := aPlugin
]
