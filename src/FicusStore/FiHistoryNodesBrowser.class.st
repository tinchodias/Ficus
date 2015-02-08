"
I'm a browser of history nodes.
"
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

	morphs add: (aHistoryNode isWorkingCopy
		ifTrue: [ '<working copy>' asText allBold asMorph lock: true; yourself ]
		ifFalse: [ aHistoryNode origin shortDescription asMorph ]).
	
	self plugin 
		prepareDescriptionMorphs: morphs 
		for: aHistoryNode.
	
	^ FiMorphBuilder default rowMorphWithAll: morphs
]

{ #category : #initialization }
FiHistoryNodesBrowser >> dropSimpleEffects: simpleEffects in: aNode [
		
	| edit newSnapshot |
	aNode isWorkingCopy ifFalse: [
		self inform: 'Not a working copy'.
		^ self ].
	
	edit := aNode snapshot editFromSimpleEffects: simpleEffects.

	newSnapshot := aNode snapshot resultOf: edit.

	aNode workingCopy snapshot: newSnapshot
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
				node isWorkingCopy
					ifTrue: [ #() ]
					ifFalse: [ node priors asArray ]
				] ].

	hiedraRulerController rulerBuilder addLinkBuilder: [ :linkBuilder |
		linkBuilder 
			width: 2.3;
			color: Color red;
			dashes: #(3 3);
			destinationsBlock: [ :node | 
				node isWorkingCopy
					ifFalse: [ #() ]
					ifTrue: [ node priors asArray ]
				] ].

]

{ #category : #initialization }
FiHistoryNodesBrowser >> initializePresenter [

	super initializePresenter.

	self initializePresenterHistoryTreeModel.
				
	refreshButton
		label: 'Refresh';
		icon: Smalltalk ui icons refreshIcon;
		action: [ self refresh ]
]

{ #category : #initialization }
FiHistoryNodesBrowser >> initializePresenterHistoryTreeModel [
		
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

	historyTreeModel
		dragEnabled: false;
		dropEnabled: true;
		wantDropBlock: [ :transfer :event :source |
			| answer |
			answer := true.
			transfer 
				valueOfProperty: #ficusSimpleEffects 
				ifAbsent: [ answer := false ].
			answer ];
		acceptDropBlock: [ :transfer :event :source :receiver | 
			| droppedSimpleEffects aNode |
			droppedSimpleEffects := (transfer valueOfProperty: #ficusSimpleEffects) collect: #content.
			aNode := receiver complexContents item.
			
			self dropSimpleEffects: droppedSimpleEffects in: aNode ].

]

{ #category : #initialization }
FiHistoryNodesBrowser >> initializeWidgets [

	self instantiateModels: #(
		historyTreeModel TreeModel
		refreshButton ButtonModel).

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
	
	| nodes workingCopies |
	store refresh.

	"should unsubscribe"
	workingCopies := self workingCopyRegistry workingCopiesForStore: store.

	nodes := OrderedCollection withAll: store historyNodes.
	nodes addAll: (workingCopies collect: #asHistoryNode).

	workingCopies do: [ :each |
		each announcer weak
			when: FiWorkingCopyRefreshed
			send: #refresh
			to: self ].
	
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
