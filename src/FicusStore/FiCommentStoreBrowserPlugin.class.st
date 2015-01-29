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
			addWorkingCopy: store newWorkingCopy; 
			addWorkingCopy: pluginWorkingCopy; 
			yourself)
]

{ #category : #'instance creation' }
FiCommentStoreBrowserPlugin class >> forWorkingCopy: aWorkingCopy [ 
	
	^ self basicNew
		initializeWithWorkingCopy: aWorkingCopy;
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
		openWithSpec
]

{ #category : #private }
FiCommentStoreBrowserPlugin >> commentsFor: aHistoryNode [ 

	^ workingCopy snapshot asArray select: [ :each | each appliesTo: aHistoryNode origin ]
]

{ #category : #initialization }
FiCommentStoreBrowserPlugin >> initializeWithWorkingCopy: aWorkingCopy [

	self initialize.
	
	workingCopy := aWorkingCopy.
	
	workingCopy announcer weak
		when: FiWorkingCopyRefreshed
		send: #announceRefreshed
		to: self.
]

{ #category : #private }
FiCommentStoreBrowserPlugin >> prepareComments: nodeComments morphs: morphs for: aHistoryNode [

	| button scores |
	scores := 
		FiMorphBuilder default rowMorphWithAll: 
			(nodeComments collect: [ :each |  
				(FiMorphBuilder default 
					tagWith: each score prettyPrintString, ' '
					backgroundColor: Color lightBrown muchLighter) ]).
	
	button := IconicButton new 
		target: self;
		actionSelector: #browseComments:;
		arguments: { aHistoryNode };
		labelGraphic: scores imageForm;
		color: Color transparent;
		helpText: 'Browse the comments';
		borderWidth: 0.

	morphs add: button
]

{ #category : #accessing }
FiCommentStoreBrowserPlugin >> prepareDescriptionMorphs: morphs for: aHistoryNode [

	(self commentsFor: aHistoryNode) 
		ifNotEmpty: [ :nodeComments | 
			self prepareComments: nodeComments morphs: morphs for: aHistoryNode ]
		ifEmpty: [ 
			self prepareNoCommentsMorphs: morphs for: aHistoryNode ]
]

{ #category : #private }
FiCommentStoreBrowserPlugin >> prepareNoCommentsMorphs: morphs for: aHistoryNode [

	| button icon |
	icon := 
		FiMorphBuilder default 
			tagWith: '+1/-1'
			backgroundColor: Color lightBrown muchLighter muchLighter
			fontColor: Color gray muchLighter.
	
	button := IconicButton new 
		target: self;
		actionSelector: #browseComments:;
		arguments: { aHistoryNode };
		labelGraphic: icon imageForm;
		color: Color transparent;
		helpText: 'Add a comment';
		borderWidth: 0.

	morphs add: button
]

{ #category : #operations }
FiCommentStoreBrowserPlugin >> removeComment: aFiComment [ 

	| newSnapshot |	
	newSnapshot := workingCopy snapshot resultOf: (FiExclude value: aFiComment).

	workingCopy snapshot: newSnapshot
]
