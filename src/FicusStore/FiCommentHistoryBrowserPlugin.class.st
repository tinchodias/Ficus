Class {
	#name : #FiCommentHistoryBrowserPlugin,
	#superclass : #FiHistoryBrowserPlugin,
	#instVars : [
		'store'
	],
	#category : #'FicusStore-History-UI'
}

{ #category : #'instance creation' }
FiCommentHistoryBrowserPlugin class >> forStore: aFiStore [ 
	
	^ self new
		store: aFiStore;
		yourself
]

{ #category : #'as yet unclassified' }
FiCommentHistoryBrowserPlugin >> browseComments: aHistoryNode [

	FiCommentBrowser new
		plugin: self;
		historyNodes: { aHistoryNode };
		openWithSpec
]

{ #category : #accessing }
FiCommentHistoryBrowserPlugin >> comments [
	
	^ store headHistoryNode snapshot
]

{ #category : #private }
FiCommentHistoryBrowserPlugin >> commentsFor: aHistoryNode [ 

	^ self comments asArray select: [ :each | each appliesTo: aHistoryNode origin ]
]

{ #category : #'as yet unclassified' }
FiCommentHistoryBrowserPlugin >> prepareDescriptionMorphs: morphs for: aHistoryNode [

	(self commentsFor: aHistoryNode) ifNotEmpty: [ :nodeComments | 
		| button |	
		button := IconicButton new 
			target: self;
			actionSelector: #browseComments:;
			arguments: { aHistoryNode };
			labelGraphic: Smalltalk ui icons announcementIcon;
			color: Color transparent;
			helpText: 'Browse the comments';
			borderWidth: 0.
		
		morphs 
			add: button;
			add: nodeComments size asString asMorph ]

]

{ #category : #accessing }
FiCommentHistoryBrowserPlugin >> store: aFiStore [ 

	store := aFiStore
]
