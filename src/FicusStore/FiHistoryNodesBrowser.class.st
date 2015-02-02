Class {
	#name : #FiHistoryNodesBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'historyTreeModel',
		'hiedraRulerController',
		'store',
		'refreshButton',
		'plugin'
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

	store headHistoryNode = aHistoryNode
		ifTrue: [ morphs add: ('[head]' asText allBold asMorph lock: true; yourself) ].
		
	morphs add: aHistoryNode origin shortDescription asMorph.
	
	self plugin 
		prepareDescriptionMorphs: morphs 
		for: aHistoryNode.
	
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
			destinationsBlock: [ :node | node priors asArray ] ]

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
	
	store refresh.
	
	historyTreeModel roots: store historyNodes reversed
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
