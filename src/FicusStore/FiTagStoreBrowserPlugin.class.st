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
	"
	Gofer new package: #ErgoPlayground; load.
	self example.
	"

	| store pluginStore |
	store := FiMonticelloStore forPackageNamed: #ErgoPlayground.
	pluginStore := FiTag exampleStoreFor: store.

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

{ #category : #'instance creation' }
FiTagStoreBrowserPlugin class >> forStore: aFiStore [ 
	
	^ self new
		store: aFiStore;
		yourself
]

{ #category : #accessing }
FiTagStoreBrowserPlugin >> prepareEffectInspectorTreeMorphs: morphs for: aSummary [

	self selectedHistoryNode ifNil: [ ^ self ].

	(self 
		tagsFor: aSummary 
		origin: self selectedHistoryNode origin 
		prior: self selectedHistoryNode priors asArray first "FIX") ifNotEmpty: [ :tags | 
			tags do: [ :each | morphs add: 
				(FiMorphBuilder default 
					tagWith: each contents
					color: Color yellow) ] ]

]

{ #category : #accessing }
FiTagStoreBrowserPlugin >> selectedHistoryNode [

	^ selectedHistoryNode
]

{ #category : #accessing }
FiTagStoreBrowserPlugin >> selectedHistoryNode: aHistoryNode [

	selectedHistoryNode := aHistoryNode
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
FiTagStoreBrowserPlugin >> tagsFor: aSummary origin: anOrigin prior: aPrior [

	^ self tags asArray select: [ :each | 
		each 
			appliesToOrigin: anOrigin
			prior: aPrior defaultStep "aHistoryNode priors asArray first" "FIX: should be the selected one"
			summaryPath: aSummary path ]
]
