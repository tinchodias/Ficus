Class {
	#name : #FiCommentStoreBrowserPlugin,
	#superclass : #FiStoreBrowserPlugin,
	#instVars : [
		'workingCopy'
	],
	#category : #'FicusStore-Comments-Plugin'
}

{ #category : #example }
FiCommentStoreBrowserPlugin class >> example [
	"
	Gofer new package: #ErgoPlayground; load.
	self example.
	"

	| store pluginWorkingCopy |
	store := FiMemoryStore exampleFragileBaseProblem.
	pluginWorkingCopy := 
		(FiComment exampleStoreFor: store) newWorkingCopy
			name: 'Comments to ', store name;
			yourself.

	FiStoreBrowser new
		store: store;
		plugin: (FiCommentStoreBrowserPlugin forWorkingCopy: pluginWorkingCopy);
		refresh;
		openWithSpec.

	FiWorkingCopyRegistryBrowser openWith: 
		(FiWorkingCopyRegistry new 
			addWorkingCopy: pluginWorkingCopy; 
			yourself)
]

{ #category : #'instance creation' }
FiCommentStoreBrowserPlugin class >> forWorkingCopy: aWorkingCopy [ 
	
	^ self new
		workingCopy: aWorkingCopy;
		yourself
]

{ #category : #operations }
FiCommentStoreBrowserPlugin >> addComment: aFiComment [ 

	| newSnapshot |	
	newSnapshot := workingCopy snapshot resultOf: (FiInclude value: aFiComment).

	workingCopy snapshot: newSnapshot.
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
	
	^ workingCopy snapshot
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
	newSnapshot := workingCopy snapshot resultOf: (FiExclude value: aFiComment).

	workingCopy snapshot: newSnapshot
]

{ #category : #accessing }
FiCommentStoreBrowserPlugin >> workingCopy: anObject [

	workingCopy := anObject
]
