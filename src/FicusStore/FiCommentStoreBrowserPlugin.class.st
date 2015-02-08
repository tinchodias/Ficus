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
	self example.
	"

	| store pluginStore pluginWorkingCopy |
	store := FiMemoryStore exampleFragileBaseProblem.
	pluginStore := FiCommentSet exampleStoreFor: store.
	pluginWorkingCopy := 
		pluginStore newWorkingCopy
			name: 'Comments to ', store name;
			yourself.

	"add fun to the example: do another commit"
	pluginStore 
		commitSnapshot: 
			(FiCommentSet 
				targetStoreName: store name 
				comments: FiSet new)
		priors: {pluginStore headHistoryNode} asFiSet.

	FiWorkingCopyRegistryBrowser openWith: 
		(FiWorkingCopyRegistry new 
			addWorkingCopy: store newWorkingCopy; 
			addWorkingCopy: pluginWorkingCopy; 
			yourself)
]

{ #category : #example }
FiCommentStoreBrowserPlugin class >> exampleFlatStore [
	"
	self exampleFlatStore.
	"

	| store pluginStore pluginWorkingCopy |
	store := FiMemoryStore exampleFragileBaseProblem.
	pluginStore := FiCommentSet exampleFlatStoreFor: store.
	pluginWorkingCopy := 
		pluginStore newWorkingCopy
			name: 'Comments to ', store name;
			yourself.

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

	| oldSnapshot newSnapshot edit |	
	oldSnapshot := workingCopy snapshot.
	
	edit := oldSnapshot 
		editAt: #comments
		do: [ :set | set editInclude: aFiComment ].

	newSnapshot := oldSnapshot resultOf: edit.

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

	^ workingCopy snapshot comments asArray 
		select: [ :each | each appliesTo: aHistoryNode origin ]
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

	aHistoryNode isWorkingCopy ifTrue: [ ^ self ].

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

	| oldSnapshot newSnapshot edit |	
	oldSnapshot := workingCopy snapshot.
	
	edit := oldSnapshot 
		editAt: #comments
		do: [ :set | set editExclude: aFiComment ].

	newSnapshot := oldSnapshot resultOf: edit.

	workingCopy snapshot: newSnapshot
]
