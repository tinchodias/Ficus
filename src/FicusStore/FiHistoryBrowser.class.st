Class {
	#name : #FiHistoryBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'historyTreeModel',
		'hiedraRulerController',
		'notes'
	],
	#category : #'FicusStore-History-UI'
}

{ #category : #'as yet unclassified' }
FiHistoryBrowser class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		add: #historyTreeModel;
		yourself
]

{ #category : #example }
FiHistoryBrowser class >> example [
	"
	self example
	"

	^ self new
		historyNodes: (FiMonticelloStore forPackageNamed: #Tetris) historyNodes;
		openWithSpec;
		yourself


]

{ #category : #accessing }
FiHistoryBrowser >> historyNodes: someNodes [ 
	
	historyTreeModel roots: someNodes
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
				displayBlock: [ :item | item content origin shortDescription ];
				initialWidth: 400;
				yourself.				

			TreeColumnModel new
				displayBlock: [ :item | self notesMorphFor: item content ];
				initialWidth: 20;
				yourself.				

			}
]

{ #category : #initialization }
FiHistoryBrowser >> initializeWidgets [

	self instantiateModels: #(
		historyTreeModel TreeModel).

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

{ #category : #'accessing - building API' }
FiHistoryBrowser >> rowSize [

	^ 23
]
