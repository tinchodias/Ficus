Class {
	#name : #FiCommentStoreBrowserPlugin,
	#superclass : #FiStoreBrowserPlugin,
	#instVars : [
		'store'
	],
	#category : #'FicusStore-UI'
}

{ #category : #'instance creation' }
FiCommentStoreBrowserPlugin class >> forStore: aFiStore [ 
	
	^ self new
		store: aFiStore;
		yourself
]

{ #category : #private }
FiCommentStoreBrowserPlugin >> browseComments: aHistoryNode [

	(FiCommentBrowser new
		plugin: self;
		historyNodes: { aHistoryNode };
		yourself)
		openDialogWithSpec modalRelativeTo: World.
]

{ #category : #accessing }
FiCommentStoreBrowserPlugin >> comments [
	
	^ store headHistoryNode snapshot
]

{ #category : #private }
FiCommentStoreBrowserPlugin >> commentsFor: aHistoryNode [ 

	^ self comments asArray select: [ :each | each appliesTo: aHistoryNode origin ]
]

{ #category : #accessing }
FiCommentStoreBrowserPlugin >> prepareDescriptionMorphs: morphs for: aHistoryNode [

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
FiCommentStoreBrowserPlugin >> store: aFiStore [ 

	store := aFiStore
]
