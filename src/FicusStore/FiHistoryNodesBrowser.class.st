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
		store: FiMemoryStore exampleFragileBaseProblem;
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
		prepareHistoryNodeDescriptionMorphs: morphs 
		for: aHistoryNode.
	
	^ FiMorphBuilder default rowMorphWithAll: morphs
]

{ #category : #initialization }
FiHistoryNodesBrowser >> dropEdit: anEdit in: aNode [
		
	| newSnapshot |
	aNode isWorkingCopy ifFalse: [
		self inform: 'Not a working copy'.
		^ self ].
	
	newSnapshot := aNode snapshot resultOf: anEdit.

	aNode workingCopy snapshot: newSnapshot.
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
		color: Smalltalk ui theme textColor.
	
	hiedraRulerController rulerBuilder addLinkBuilder: [ :linkBuilder |
		linkBuilder 
			width: 2.3;
			color: Color red;
			conditionBlock: [ :node | node isWorkingCopy not ];
			destinationsBlock: [ :node | node priors asArray ] ].

	hiedraRulerController rulerBuilder addLinkBuilder: [ :linkBuilder |
		linkBuilder 
			width: 2.3;
			color: Color red;
			dashes: #(3 3);
			conditionBlock: [ :node | node isWorkingCopy ];
			destinationsBlock: [ :node | node priors asArray ] ].

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
		
			hiedraRulerController newTreeColumnModel.
				
			TreeColumnModel new
				displayBlock: [ :item | self descriptionMorphFor: item content ];
				initialWidth: 800;
				yourself.				
			}.

	historyTreeModel
		menu: [ :aMenu | self prepareMenu: aMenu ];
		dragEnabled: false;
		dropEnabled: true;
		wantDropBlock: [ :transfer :event :source |
			| answer |
			answer := true.
			transfer 
				valueOfProperty: #ficusEdit 
				ifAbsent: [ answer := false ].
			answer ];
		acceptDropBlock: [ :transfer :event :source :receiver | 
			| droppedEdit aNode |
			droppedEdit := transfer valueOfProperty: #ficusEdit.
			aNode := receiver complexContents item.
			
			self dropEdit: droppedEdit in: aNode ].

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

	plugin := aPlugin.
	
	aPlugin announcer weak
		when: FiStoreBrowserPluginRefreshed 
		send: #pluginRefreshed
		to: self.
]

{ #category : #refreshing }
FiHistoryNodesBrowser >> pluginRefreshed [
		
	historyTreeModel updateTree
]

{ #category : #private }
FiHistoryNodesBrowser >> prepareMenu: aMenu [

	historyTreeModel selectedItems ifNotEmpty: [ 
		self plugin prepareHistoryNodeMenu: aMenu ]
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
