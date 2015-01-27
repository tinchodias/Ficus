Class {
	#name : #FiCommentStoreBrowserPlugin,
	#superclass : #FiStoreBrowserPlugin,
	#instVars : [
		'store'
	],
	#category : #'FicusStore-Comments-Plugin'
}

{ #category : #example }
FiCommentStoreBrowserPlugin class >> example [
	"
	Gofer new package: #ErgoPlayground; load.
	self example.
	"

	| store pluginStore |
	store := FiMonticelloStore forPackageNamed: #ErgoPlayground.
	pluginStore := FiComment exampleStoreFor: store.

	FiStoreBrowser new
		store: store;
		plugin: (FiCommentStoreBrowserPlugin forStore: pluginStore);
		refresh;
		openWithSpec.
		
	FiStoreBrowser new
		store: pluginStore;
		plugin: FiNullStoreBrowserPlugin new;
		refresh;
		openWithSpec.
]

{ #category : #'instance creation' }
FiCommentStoreBrowserPlugin class >> forStore: aFiStore [ 
	
	^ self new
		store: aFiStore;
		yourself
]

{ #category : #operations }
FiCommentStoreBrowserPlugin >> addComment: aFiComment [ 

	| newSnapshot |	
	self flag: #todo. "Replace store by a working copy"

	newSnapshot := store headHistoryNode snapshot resultOf: (FiInclude value: aFiComment).

	store 
		commitSnapshot: newSnapshot
		priors: {store headHistoryNode}.
]

{ #category : #private }
FiCommentStoreBrowserPlugin >> browseComments: aHistoryNode [

	(FiCommentBrowser new
		plugin: self;
		targetHistoryNode: aHistoryNode;
		yourself)
		openDialogWithSpec modalRelativeTo: self currentWorld.
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

{ #category : #operations }
FiCommentStoreBrowserPlugin >> removeComment: aFiComment [ 

	| newSnapshot |	
	self flag: #todo. "Replace store by a working copy"

	newSnapshot := store headHistoryNode snapshot resultOf: (FiExclude value: aFiComment).

	store 
		commitSnapshot: newSnapshot
		priors: {store headHistoryNode}.
]

{ #category : #accessing }
FiCommentStoreBrowserPlugin >> store: aFiStore [ 

	store := aFiStore
]
