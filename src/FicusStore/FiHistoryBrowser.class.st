Class {
	#name : #FiHistoryBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'historyTreeModel',
		'hiedraRulerController',
		'notes',
		'store',
		'refreshButton'
	],
	#category : #'FicusStore-History-UI'
}

{ #category : #specs }
FiHistoryBrowser class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed 
		newColumn: [ :column | 
			column
				add: #historyTreeModel;
				add: #refreshButton height: self buttonHeight ];
		yourself
]

{ #category : #example }
FiHistoryBrowser class >> example [
	"
	self example
	"

	^ self new
		store: (FiMonticelloStore forPackageNamed: #Tetris);
		notes: #();
		refresh;
		openWithSpec;
		yourself


]

{ #category : #private }
FiHistoryBrowser >> descriptionMorphFor: aHistoryNode [ 

	^ ((store headHistoryNode = aHistoryNode
		ifTrue: [ '[head] ' asText allBold ]
		ifFalse: [ '' ]), aHistoryNode origin shortDescription) asMorph lock: true; yourself
]

{ #category : #accessing }
FiHistoryBrowser >> historyTreeModel [

	^ historyTreeModel
]

{ #category : #initialization }
FiHistoryBrowser >> initializeHiedraController [

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
FiHistoryBrowser >> initializePresenter [

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
				initialWidth: 400;
				yourself.				

			TreeColumnModel new
				displayBlock: [ :item | self notesMorphFor: item content ];
				initialWidth: 20;
				yourself.				
			}.
			
	refreshButton
		label: 'Refresh';
		icon: Smalltalk ui icons refreshIcon;
		action: [ self refresh ]
]

{ #category : #initialization }
FiHistoryBrowser >> initializeWidgets [

	self instantiateModels: #(
		historyTreeModel TreeModel
		refreshButton ButtonModel).

]

{ #category : #accessing }
FiHistoryBrowser >> notes: someNotes [ 
	
	notes := someNotes
]

{ #category : #private }
FiHistoryBrowser >> notesFor: aHistoryNode [ 

	^ notes select: [ :each | each appliesTo: aHistoryNode origin ]
]

{ #category : #private }
FiHistoryBrowser >> notesMorphFor: aHistoryNode [ 

	^ (self notesFor: aHistoryNode)
		ifEmpty: [ Smalltalk ui icons emptyIcon ]
		ifNotEmpty: [ :theNotes | 
			self rowMorphWithAll: {
				Smalltalk ui icons announcementIcon asMorph.
				theNotes size asString asMorph } ]
]

{ #category : #refreshing }
FiHistoryBrowser >> refresh [
	
	store refresh.
	
	historyTreeModel roots: (store historyNodes)
]

{ #category : #accessing }
FiHistoryBrowser >> refreshButton [

	^ refreshButton
]

{ #category : #private }
FiHistoryBrowser >> rowMorphWithAll: someMophs [

	^ PanelMorph new
		changeTableLayout;
		vResizing: #shrinkWrap;
		hResizing: #shrinkWrap;
		listDirection: #leftToRight;
		cellInset: 3;
		addAllMorphs: someMophs;
		yourself
]

{ #category : #private }
FiHistoryBrowser >> rowSize [

	^ 23
]

{ #category : #accessing }
FiHistoryBrowser >> store: aFiStore [
	
	store := aFiStore
]
