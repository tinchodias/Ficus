Class {
	#name : #FiCommentBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'commentsTreeModel',
		'plugin'
	],
	#category : #'FicusStore-Comments-UI'
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

	self title: 'Ficus Comments Browser'.

	commentsTreeModel 
		displayBlock: [ :aComment | self morphFor: aComment ]	";
		menu: [ :aMenu | self setUpMenu: aMenu ]"

]

{ #category : #initialization }
FiCommentBrowser >> initializeWidgets [

	self instantiateModels: #(
		commentsTreeModel TreeModel).

]

{ #category : #private }
FiCommentBrowser >> morphFor: aComment [

	^ ((aComment score prettyPrintString asText 
			addAttribute: (TextFontChange fontNumber: 3); "bigger than normal"
"			addAttribute: (TextColor color: Color gray);"
			yourself), 
			String cr, 
			aComment contents) asText asMorph 
				lock: true; 
				yourself
]

{ #category : #accessing }
FiCommentBrowser >> plugin [

	^ plugin
]

{ #category : #accessing }
FiCommentBrowser >> plugin: aPlugin [

	plugin := aPlugin
]

{ #category : #initialization }
FiCommentBrowser >> setUpMenu: aMenu [

	aMenu addGroup: [ :aGroup |
		
		aGroup addItem: [ :anItem |
			anItem 
				name: 'New ';
				description: 'Create a new comment';
				icon: Smalltalk ui icons addIcon;
				shortcut: $n command;
				action: [ self halt ] ].
		].

]
