Class {
	#name : #FiStoreBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'historyBrowserModel',
		'tabManagerModel',
		'snapshotModel',
		'snapshotTabModel',
		'deltasModel',
		'deltasTabModel'
	],
	#category : #'FicusStore-UI'
}

{ #category : #specs }
FiStoreBrowser class >> defaultSpec [
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
FiStoreBrowser class >> example [
	"
	self example
	"

	^ self new
		store: (FiMonticelloStore forPackageNamed: #Tetris);
		plugin: FiNullStoreBrowserPlugin new;
		refresh;
		openWithSpec;
		yourself


]

{ #category : #accessing }
FiStoreBrowser >> deltasModel [
	
	^ deltasModel
]

{ #category : #accessing }
FiStoreBrowser >> deltasTabModel [
	
	^ deltasTabModel
]

{ #category : #accessing }
FiStoreBrowser >> historyBrowserModel [
	
	^ historyBrowserModel
]

{ #category : #protocol }
FiStoreBrowser >> initialExtent [

	^ 850 @ 600

]

{ #category : #initialization }
FiStoreBrowser >> initializePresenter [

	super initializePresenter.

	self title: 'Ficus Store Browser'.
 	
	self initializeTabs. 
	
	historyBrowserModel historyTreeModel
		whenSelectedItemsChanged: [ :selectedItems | 
			| actuallySelectedTab |
			actuallySelectedTab := 
				tabManagerModel selectedTab 
					ifNil: [ 	snapshotTabModel ] "This is a workaround because you can not convince Spec that the tab initially selected is actually selected."
					ifNotNil: [ :tabModel | tabModel ].
			
			selectedItems ifNotEmpty: [
				self plugin selectedHistoryNode: selectedItems anyOne. self flag: #fix. "Transmit to plugin" ].

			actuallySelectedTab tabSelected ]
]

{ #category : #initialization }
FiStoreBrowser >> initializeTabs [

	snapshotTabModel
		label: 'Snapshot';
		icon: Smalltalk ui icons smallSaveIcon;
		model: self snapshotModel;
		whenTabSelected: [ self refreshSnapshotTab ];
		closeable: false.
		
	deltasTabModel
		label: 'Deltas';
		icon: Smalltalk ui icons smallJustifiedIcon;
		model: self deltasModel;
		whenTabSelected: [ self refreshDeltasTab ];
		closeable: false.

	tabManagerModel 
		addTab: snapshotTabModel;
		addTab: deltasTabModel;
		selectTabModel: snapshotTabModel.
]

{ #category : #initialization }
FiStoreBrowser >> initializeWidgets [

	self instantiateModels: {
		#historyBrowserModel -> #FiHistoryNodesBrowser.

		"tabs"
		#tabManagerModel -> #TabManagerModel.
		#snapshotTabModel -> #TabModel.
		#deltasTabModel -> #TabModel.
		
		"tabs content"
		#snapshotModel -> #FiInspector. 
		#deltasModel -> #FiDeltasInspector. 
		}.

]

{ #category : #accessing }
FiStoreBrowser >> plugin [
	
	^ historyBrowserModel plugin
]

{ #category : #accessing }
FiStoreBrowser >> plugin: aPlugin [
	
	historyBrowserModel plugin: aPlugin.
	deltasModel plugin: aPlugin.
]

{ #category : #refreshing }
FiStoreBrowser >> refresh [
	
	historyBrowserModel refresh
]

{ #category : #private }
FiStoreBrowser >> refreshDeltasTab [

	deltasModel deltas: 
		(self selectedHistoryNodes
			ifEmpty: [ #() ]
			ifNotEmpty: [ :selection |
				selection anyOne deltas ])

]

{ #category : #private }
FiStoreBrowser >> refreshSnapshotTab [

	| selection |
	selection := self selectedHistoryNodes. 
	
	selection 
		ifEmpty: [ snapshotModel emptyRoots ]
		ifNotEmpty: [ 
			snapshotModel rootAssociations: (selection anyOne snapshot stepsAndValues sorted: [ :a :b | a key <= b key ]) ]
]

{ #category : #accessing }
FiStoreBrowser >> selectedHistoryNodes [
	
	^ historyBrowserModel historyTreeModel selectedItems collect: #content
]

{ #category : #accessing }
FiStoreBrowser >> snapshotModel [
	
	^ snapshotModel
]

{ #category : #accessing }
FiStoreBrowser >> snapshotTabModel [
	
	^ snapshotTabModel
]

{ #category : #accessing }
FiStoreBrowser >> store: aFiStore [
	
	historyBrowserModel store: aFiStore
]

{ #category : #accessing }
FiStoreBrowser >> tabManagerModel [
	
	^ tabManagerModel
]
