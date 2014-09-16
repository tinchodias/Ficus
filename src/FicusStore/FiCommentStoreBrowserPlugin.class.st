Class {
	#name : #FiCommentStoreBrowserPlugin,
	#superclass : #FiStoreBrowserPlugin,
	#instVars : [
		'store'
	],
	#category : #'FicusStore-Comments-Plugin'
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
		| button scores |
		scores := 
			FiMorphBuilder default rowMorphWithAll: 
				(nodeComments collect: [ :each |  
					(FiMorphBuilder default 
						tagWith: each score prettyPrintString, ' '
						color: Color lightBrown muchLighter) ]).
		
		button := IconicButton new 
			target: self;
			actionSelector: #browseComments:;
			arguments: { aHistoryNode };
			labelGraphic: scores imageForm;
			color: Color transparent;
			helpText: 'Browse the comments';
			borderWidth: 0.

		morphs add: button ]

]

{ #category : #accessing }
FiCommentStoreBrowserPlugin >> store: aFiStore [ 

	store := aFiStore
]
