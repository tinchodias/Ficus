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
			| actuallySelectedTab |
			actuallySelectedTab := 
				tabManagerModel selectedTab 
					ifNil: [ 	snapshotTabModel ] "This is a workaround because you can not convince Spec that the tab initially selected is actually selected."
					ifNotNil: [ :tabModel | tabModel ].
					
			actuallySelectedTab tabSelected ]
]

{ #category : #initialization }
FiFullHistoryBrowser >> initializeTabs [

	snapshotTabModel
		label: 'Snapshot';
		icon: Smalltalk ui icons smallOpenIcon;
		model: self snapshotModel;
		whenTabSelected: [ self refreshSnapshotTab ];
		closeable: false.
		
	differenceTabModel
		label: 'Difference';
		icon: Smalltalk ui icons smallFindIcon;
		model: self differenceModel;
		whenTabSelected: [ self refreshDifferenceTab ];
		closeable: false.

	tabManagerModel 
		addTab: snapshotTabModel;
		addTab: differenceTabModel;
		selectTabModel: snapshotTabModel.
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
		#snapshotModel -> #FiInspector2. 
		#differenceModel -> #FiEffectInspector2. 
		}.

]

{ #category : #'as yet unclassified' }
FiFullHistoryBrowser >> notes: someNotes [ 
	
	historyBrowserModel notes: someNotes
]

{ #category : #private }
FiFullHistoryBrowser >> refreshDifferenceTab [

	| difference selection |
	selection := self selectedHistoryNodes. 
	
	difference := selection 
		ifEmpty: [ FiNoEffect new ]
		ifNotEmpty: [ 
			selection anyOne patches 
				ifEmpty: [ FiNoEffect new ]
				ifNotEmpty: [ :patches | patches first value ] ].
		
	differenceModel rootEffect: difference
]

{ #category : #private }
FiFullHistoryBrowser >> refreshSnapshotTab [

	| selection |
	selection := self selectedHistoryNodes. 
	
	selection 
		ifEmpty: [ snapshotModel emptyRoots ]
		ifNotEmpty: [ snapshotModel rootAssociations: (selection anyOne snapshot contents stepsAndValues sorted: [ :a :b | a key <= b key ]) ]
]

{ #category : #accessing }
FiFullHistoryBrowser >> selectedHistoryNodes [
	
	^ historyBrowserModel historyTreeModel selectedItems collect: #content
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
