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
		'differenceModel',
		'historyModel'
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
						add: #historyModel;
						add: #commitModel;
						add: #differenceModel;
						add: #inspectModel ]
				height: self toolbarHeight ];
		yourself
]

{ #category : #example }
FiWorkingCopyRegistryBrowser class >> example [
	"
	self example
	"

	| bundle aWorkingCopy anotherWorkingCopy |
	aWorkingCopy := 
		FiWorkingCopy new
			name: 'FragileBaseClassProblem';
			snapshot: FiFragileBaseProblemResourcesA new environmentWithAll;
			store: FiMemoryStore exampleFragileBaseProblem;
			yourself.

	anotherWorkingCopy := 
		FiWorkingCopy new
			name: 'Numbers';
			snapshot: FiSet new;
			store: FiMemoryStore example;
			yourself.
		
	bundle := 
		FiWorkingCopyRegistry new 
			addWorkingCopy: aWorkingCopy; 
			addWorkingCopy: anotherWorkingCopy;
			yourself.

	^ self new
		model: bundle;
		refresh;
		openWithSpec;
		yourself


]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> commitModel [

	^ commitModel
]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> differenceModel [

	^ differenceModel
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
		displayBlock: [ :item |
			item description ].

	historyModel
		label: 'Open';
		action: [ 
			workingCopiesModel selectedItems do: [ :each | 
				FiStoreBrowser new
					store: each content store;
					plugin: FiNullStoreBrowserPlugin new;
					refresh;
					openWithSpec;
					yourself ] ].
 	
	commitModel
		label: 'Commit';
		action: [ 
			workingCopiesModel selectedItems do: [ :each | 
				each content commit: 'a message'.
				self refresh. ] ].
	
	differenceModel
		label: 'Difference';
		action: [ 
			workingCopiesModel selectedItems do: [ :each |
				FiEffectInspector inspect: each content difference ] ].
	
	inspectModel
		label: 'Inspect';
		action: [ 
			workingCopiesModel selectedItems do: [ :each | 
				each content inspect ] ].
	
]

{ #category : #initialization }
FiWorkingCopyRegistryBrowser >> initializeWidgets [

	self instantiateModels: {
		#workingCopiesModel -> #TreeModel.
		#historyModel -> #ButtonModel.
		#commitModel -> #ButtonModel.
		#differenceModel -> #ButtonModel.
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

{ #category : #refreshing }
FiWorkingCopyRegistryBrowser >> refresh [
	
	model refresh.
	workingCopiesModel roots: model workingCopies
]

{ #category : #accessing }
FiWorkingCopyRegistryBrowser >> workingCopiesModel [

	^ workingCopiesModel
]
