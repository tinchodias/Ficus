Class {
	#name : #FiHistoryBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'historyTreeModel',
		'hiedraRulerController'
	],
	#category : #'FicusStore-HistoryNodes'
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
		historyNodes: FiMonticelloHistoryBuilder forFuelTests historyNodes;
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
		width: 3.5;
		color: Color purple.	
	
	hiedraRulerController rulerBuilder addLinkBuilder: [ :linkBuilder |
		linkBuilder 
			width: 3;
			color: Color blue;
			destinationsBlock: [ :node | node priors asArray ] ].
		
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
				displayBlock: [ :item | item content origin printString ];
				initialWidth: 250;
				yourself.				
			}
]

{ #category : #initialization }
FiHistoryBrowser >> initializeWidgets [

	self instantiateModels: #(
		historyTreeModel TreeModel).

]

{ #category : #'accessing - building API' }
FiHistoryBrowser >> rowSize [

	^ 23
]
