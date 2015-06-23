"
I am a browser of FiWorkingCopyRegistry. 

See examples in class-side.
"
Class {
	#name : #FiWorkingCopyRegistryBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'workingCopiesModel',
		'commitModel',
		'model',
		'inspectModel',
		'historyModel',
		'browseModel',
		'refreshModel',
		'deltaModel'
	],
	#category : #'FicusStore-WorkingCopies'
}

{ #category : #specs }
FiWorkingCopyRegistryBrowser class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		newColumn: [ :col |
			col
				add: #workingCopiesModel;
				newRow: [ :toolBar |
					toolBar 
						add: #refreshModel;
						add: #historyModel;
						add: #commitModel;
						add: #browseModel;
						add: #deltaModel;
						add: #inspectModel ]
				height: self toolbarHeight ];
		yourself
]

{ #category : #'instance creation' }
FiWorkingCopyRegistryBrowser class >> openWith: registry [ 

	^ self new
		model: registry;
		refresh;
		openWithSpec;
		yourself


]

{ #category : #private }
FiWorkingCopyRegistryBrowser >> actionBrowse [

	workingCopiesModel selectedItems do: [ :each |
		FiInspector inspect: each content snapshot ]
]

{ #category : #private }
FiWorkingCopyRegistryBrowser >> actionCommit [

	workingCopiesModel selectedItems do: [ :each | 
		each content commit: 'a message'.
		self refresh. ]
]

{ #category : #private }
FiWorkingCopyRegistryBrowser >> actionDelta [

	workingCopiesModel selectedItems do: [ :each |
		FiChangeInspector inspect: each content delta ]
]

{ #category : #private }
FiWorkingCopyRegistryBrowser >> actionInspect [

	workingCopiesModel selectedItems do: [ :each | 
		each content inspect ]
]

{ #category : #private }
FiWorkingCopyRegistryBrowser >> actionOpen [

	workingCopiesModel selectedItems do: [ :each | 
		FiStoreBrowser new
			store: each content store;
			workingCopyRegistry: model;
			plugin: (self newStoreBrowserPluginFor: each content store);
			refresh;
			openWithSpec;
			yourself ]
]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> browseModel [

	^ browseModel
]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> commitModel [

	^ commitModel
]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> deltaModel [
	^ deltaModel
]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> historyModel [

	^ historyModel
]

{ #category : #protocol }
FiWorkingCopyRegistryBrowser >> initialExtent [

	^ 400 @ 400

]

{ #category : #initialization }
FiWorkingCopyRegistryBrowser >> initializePresenter [

	self title: 'Ficus Working Copy Registry Browser'.

	workingCopiesModel
		displayBlock: [ :item | item description ];
		doubleClick: [ self actionOpen ].

	refreshModel
		label: 'Refresh';
		action: [ self refresh ].

	historyModel
		label: 'Open';
		action: [ self actionOpen ].
 	
	commitModel
		label: 'Commit';
		action: [ self actionCommit ].
	
	deltaModel
		label: 'Delta';
		action: [ self actionDelta ].

	browseModel
		label: 'Browse';
		action: [ self actionBrowse ].
	
	inspectModel
		label: 'Inspect';
		action: [ self actionInspect ].
	
]

{ #category : #initialization }
FiWorkingCopyRegistryBrowser >> initializeWidgets [

	self instantiateModels: {
		#workingCopiesModel -> #TreeModel.
		#refreshModel -> #ButtonModel.
		#historyModel -> #ButtonModel.
		#browseModel -> #ButtonModel.
		#commitModel -> #ButtonModel.
		#deltaModel -> #ButtonModel.
		#inspectModel -> #ButtonModel.
		}.

]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> inspectModel [

	^ inspectModel
]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> model: aModel [
	
	model := aModel
]

{ #category : #private }
FiWorkingCopyRegistryBrowser >> newStoreBrowserPluginFor: aFiStore [ 
	
	^ model workingCopies
		detect: [ :workingCopy | 
			(workingCopy snapshot isKindOf: FiCommentSet) and: [ 
			workingCopy snapshot targetStoreName = aFiStore name ]]
		ifFound: [ :commentsWorkingCopy | 
			FiCommentStoreBrowserPlugin forWorkingCopy: commentsWorkingCopy ]
		ifNone: [ FiNullStoreBrowserPlugin new ].
	
	
]

{ #category : #refreshing }
FiWorkingCopyRegistryBrowser >> refresh [
	
	"unsubscribe before refreshing model"
	model workingCopies do: [ :workingCopy |
		workingCopy announcer unsubscribe: self ].
	
	model refresh.
	workingCopiesModel roots: model workingCopies.
	
	"subscribe after refreshing model"
	model workingCopies do: [ :workingCopy |
		workingCopy announcer weak
			when: FiWorkingCopyRefreshed 
			send: #refresh
			to: self ]
]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> refreshModel [

	^ refreshModel
]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> workingCopiesModel [

	^ workingCopiesModel
]
