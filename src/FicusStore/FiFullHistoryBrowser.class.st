Class {
	#name : #FiFullHistoryBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'historyBrowserModel',
		'tabManagerModel',
		'snapshotModel',
		'snapshotTabModel',
		'differenceModel',
		'differenceTabModel'
	],
	#category : #'FicusStore-HistoryNodes'
}

{ #category : #specs }
FiFullHistoryBrowser class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		newRow: [:row | 
			row
				add: #historyBrowserModel;
				addSplitter;
				add: #tabManagerModel ];
		yourself
]

{ #category : #example }
FiFullHistoryBrowser class >> example [
	"
	self example
	"

	^ self new
		historyNodes: FiMonticelloHistoryBuilder forFuelTests historyNodes;
		openWithSpec;
		yourself


]

{ #category : #accessing }
FiFullHistoryBrowser >> differenceModel [
	
	^ differenceModel
]

{ #category : #accessing }
FiFullHistoryBrowser >> differenceTabModel [
	
	^ differenceTabModel
]

{ #category : #accessing }
FiFullHistoryBrowser >> historyBrowserModel [
	
	^ historyBrowserModel
]

{ #category : #accessing }
FiFullHistoryBrowser >> historyNodes: someNodes [ 
	
	historyBrowserModel historyNodes: someNodes
]

{ #category : #initialization }
FiFullHistoryBrowser >> initializePresenter [

	super initializePresenter.

	self title: 'Ficus Full History Browser'.
 	
	self initializeTabs.
	
	historyBrowserModel historyTreeModel
		whenSelectedItemsChanged: [ :selectedItems | 
			| difference | 
			difference := selectedItems 
				ifEmpty: [ FiNoEffect new ]
				ifNotEmpty: [ 
					selectedItems anyOne patches 
						ifEmpty: [ FiNoEffect new ]
						ifNotEmpty: [ :patches | patches first value ] ].
				
			differenceModel rootEffect: difference ]
]

{ #category : #initialization }
FiFullHistoryBrowser >> initializeTabs [

	snapshotTabModel
		label: 'Snapshot';
		icon: Smalltalk ui icons smallOpenIcon;
		model: self snapshotModel;
		closeable: false.
		
	differenceTabModel
		label: 'Difference';
		icon: Smalltalk ui icons smallFindIcon;
		model: self differenceModel;
		closeable: false.

	tabManagerModel 
		addTab: snapshotTabModel;
		addTab: differenceTabModel.
	
]

{ #category : #initialization }
FiFullHistoryBrowser >> initializeWidgets [

	self instantiateModels: {
		#historyBrowserModel -> #FiHistoryBrowser.

		"tabs"
		#tabManagerModel -> #TabManagerModel.
		#snapshotTabModel -> #TabModel.
		#differenceTabModel -> #TabModel.
		
		"tabs content"
		#snapshotModel -> #TreeModel. 
		#differenceModel -> #FiEffectInspector2. 
		}.

]

{ #category : #accessing }
FiFullHistoryBrowser >> snapshotModel [
	
	^ snapshotModel
]

{ #category : #accessing }
FiFullHistoryBrowser >> snapshotTabModel [
	
	^ snapshotTabModel
]

{ #category : #accessing }
FiFullHistoryBrowser >> tabManagerModel [
	
	^ tabManagerModel
]
