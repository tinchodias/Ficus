Class {
	#name : #FiHistoryNodesBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'historyTreeModel',
		'hiedraRulerController',
		'store',
		'refreshButton',
		'plugin',
		'workingCopyRegistry'
	],
	#category : #'FicusStore-UI-Widgets'
}

{ #category : #specs }
FiHistoryNodesBrowser class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed 
		newColumn: [ :column | 
			column
				add: #historyTreeModel;
				add: #refreshButton height: self buttonHeight ];
		yourself
]

{ #category : #example }
FiHistoryNodesBrowser class >> example [
	"
	self example
	"

	^ self new
		store: (FiMonticelloStore forPackageNamed: #Tetris);
		refresh;
		openWithSpec;
		yourself


]

{ #category : #private }
FiHistoryNodesBrowser >> descriptionMorphFor: aHistoryNode [ 

	| morphs |
	morphs := OrderedCollection new.

	morphs add: ((self isWorkingCopy: aHistoryNode)
		ifTrue: [ '[working copy]' asText allBold asMorph lock: true; yourself ]
		ifFalse: [ aHistoryNode origin shortDescription asMorph ]).
	
	self flag: #todo. "maybe not necessary, but..."
	(self isWorkingCopy: aHistoryNode) ifFalse: [
		self plugin 
			prepareDescriptionMorphs: morphs 
			for: aHistoryNode ].
	
	^ FiMorphBuilder default rowMorphWithAll: morphs
]

{ #category : #accessing }
FiHistoryNodesBrowser >> historyTreeModel [

	^ historyTreeModel
]

{ #category : #initialization }
FiHistoryNodesBrowser >> initializeHiedraController [

	hiedraRulerController := HiRulerController new.
	
	hiedraRulerController treeModel: historyTreeModel.
	historyTreeModel whenRootsChanged: [ 
		hiedraRulerController updateFromTree ].
	
	hiedraRulerController rulerBuilder
		rowSize: self rowSize;
		columnSize: self rowSize // 2.5.
	
	hiedraRulerController rulerBuilder nodeBuilder
		width: 5.15;
		color: Color black.
	
	hiedraRulerController rulerBuilder addLinkBuilder: [ :linkBuilder |
		linkBuilder 
			width: 2.3;
			color: Color red;
			destinationsBlock: [ :node | 
				(self isWorkingCopy: node)
					ifTrue: [ #() ]
					ifFalse: [ node priors asArray ]
				] ].

	hiedraRulerController rulerBuilder addLinkBuilder: [ :linkBuilder |
		linkBuilder 
			width: 2.3;
			color: Color red;
			dashes: #(3 3);
			destinationsBlock: [ :node | 
				(self isWorkingCopy: node)
					ifFalse: [ #() ]
					ifTrue: [ node priors asArray ]
				] ].

]

{ #category : #initialization }
FiHistoryNodesBrowser >> initializePresenter [

	super initializePresenter.

	self initializeHiedraController. 

	historyTreeModel
		rowInset: 0;
		columns: { 
			TreeColumnModel new	
				displayBlock: [ :item | hiedraRulerController rowMorphFor: item content ];
				yourself.
				
			TreeColumnModel new
				displayBlock: [ :item | self descriptionMorphFor: item content ];
				initialWidth: 800;
				yourself.				
			}.
			
	refreshButton
		label: 'Refresh';
		icon: Smalltalk ui icons refreshIcon;
		action: [ self refresh ]
]

{ #category : #initialization }
FiHistoryNodesBrowser >> initializeWidgets [

	self instantiateModels: #(
		historyTreeModel TreeModel
		refreshButton ButtonModel).

]

{ #category : #private }
FiHistoryNodesBrowser >> isWorkingCopy: aHistoryNode [

	self flag: #todo. "fix"
	^ aHistoryNode origin isNil

]

{ #category : #accessing }
FiHistoryNodesBrowser >> plugin [

	^ plugin ifNil: [ plugin := FiNullStoreBrowserPlugin new ]
]

{ #category : #accessing }
FiHistoryNodesBrowser >> plugin: aPlugin [

	plugin := aPlugin
]

{ #category : #refreshing }
FiHistoryNodesBrowser >> refresh [
	
	| nodes |
	store refresh.

	nodes := store historyNodes copy.
	nodes addAll: ((self workingCopyRegistry workingCopiesForStore: store)
		collect: #asHistoryNode).
	
	historyTreeModel roots: nodes reversed.
]

{ #category : #accessing }
FiHistoryNodesBrowser >> refreshButton [

	^ refreshButton
]

{ #category : #private }
FiHistoryNodesBrowser >> rowSize [

	^ 28
]

{ #category : #accessing }
FiHistoryNodesBrowser >> store: aFiStore [
	
	store := aFiStore
]

{ #category : #accessing }
FiHistoryNodesBrowser >> workingCopyRegistry [

	^ workingCopyRegistry ifNil: [
		workingCopyRegistry := FiWorkingCopyRegistry new ]
]

{ #category : #accessing }
FiHistoryNodesBrowser >> workingCopyRegistry: aWorkingCopyRegistry [

	workingCopyRegistry := aWorkingCopyRegistry
]
