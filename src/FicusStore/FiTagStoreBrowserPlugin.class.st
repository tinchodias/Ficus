Class {
	#name : #FiTagStoreBrowserPlugin,
	#superclass : #FiStoreBrowserPlugin,
	#instVars : [
		'store',
		'selectedHistoryNode'
	],
	#category : #'FicusStore-Tags-Plugin'
}

{ #category : #example }
FiTagStoreBrowserPlugin class >> example [

	| store pluginStore |
	store := FiMemoryStore exampleFragileBaseProblem.
	pluginStore := self exampleStoreFor: store.

	FiStoreBrowser new
		store: store;
		plugin: (FiTagStoreBrowserPlugin forStore: pluginStore);
		refresh;
		openWithSpec.

	FiStoreBrowser new
		store: pluginStore;
		plugin: FiNullStoreBrowserPlugin new;
		refresh;
		openWithSpec.
]

{ #category : #example }
FiTagStoreBrowserPlugin class >> exampleStoreFor: store [

	| delta1 delta2 tags tagsStore |
	delta1 := store historyNodes second deltas anyOne.
	delta2 := store historyNodes third deltas anyOne.
	
	tags := { 
		FiTag builder 
			origin: store historyNodes second origin;
			priorDefaultStep: delta1 key defaultStep;
			path: delta1 value asSimpleEffects anyOne path; 
			contents: 'Reformatting code';
			new.
		FiTag builder 
			origin: store historyNodes third origin;
			priorDefaultStep: delta2 key defaultStep;
			path: delta1 value asSimpleEffects anyOne path;
			contents: 'Refactoring A->B';
			new.
	 }.

	tagsStore := FiMemoryStore new.
	tagsStore commitSnapshot: FiSet new priors: FiSet new.

	1 to: tags size do: [ :index |
		tagsStore 
			commitSnapshot: (tags first: index) asFiSet 
			priors: {tagsStore headHistoryNode} asFiSet ].

	^ tagsStore
]

{ #category : #'instance creation' }
FiTagStoreBrowserPlugin class >> forStore: aFiStore [ 
	
	^ self new
		store: aFiStore;
		yourself
]

{ #category : #accessing }
FiTagStoreBrowserPlugin >> prepareEffectDescriptionMorphs: morphs for: aSimpleEffect [

	selectedHistoryNode ifNil: [ ^ self ].

	(self 
		tagsFor: aSimpleEffect 
		origin: selectedHistoryNode origin 
		prior: selectedHistoryNode priors asArray first "FIX") ifNotEmpty: [ :tags | 
			tags do: [ :each | morphs add: 
				(FiMorphBuilder default 
					tagWith: each contents
					backgroundColor: Color yellow) ] ]

]

{ #category : #accessing }
FiTagStoreBrowserPlugin >> selectedHistoryNodes: historyNodes [

	historyNodes ifEmpty: [ ^ self ].
	self assert: historyNodes size = 1.

	selectedHistoryNode := historyNodes anyOne.
]

{ #category : #accessing }
FiTagStoreBrowserPlugin >> store: aFiStore [ 

	store := aFiStore
]

{ #category : #accessing }
FiTagStoreBrowserPlugin >> tags [
	
	^ store headHistoryNode snapshot
]

{ #category : #private }
FiTagStoreBrowserPlugin >> tagsFor: aSimpleEffect origin: anOrigin prior: aPrior [

	^ self tags asArray select: [ :each | 
		each 
			appliesToOrigin: anOrigin
			prior: aPrior defaultStep "aHistoryNode priors asArray first" "FIX: should be the selected one"
			path: aSimpleEffect path ]
]
