"
I'm a plugin that shows dependency nformation into the browser.
"
Class {
	#name : #FiImpactStoreBrowserPlugin,
	#superclass : #FiStoreBrowserPlugin,
	#instVars : [
		'selectedEffect',
		'selectedHistoryNode',
		'dependenciesByHistoryNode',
		'backgroundExecutor',
		'environmentalPackages',
		'environmentByHistoryNode'
	],
	#category : #'FicusImpact-UI'
}

{ #category : #examples }
FiImpactStoreBrowserPlugin class >> example [
	"
	self example.
	"

	self exampleFragileBaseProblemWith: FiBaseResources new ficusEnvironment asArray
]

{ #category : #examples }
FiImpactStoreBrowserPlugin class >> exampleFragileBaseProblemWith: environmentalPackages [

	| store registry plugin |
	store := FiMemoryStore exampleFragileBaseProblemOnlyPackage.

	plugin := self new
		environmentalPackages: environmentalPackages;
		yourself.	
	
	registry :=
		(FiWorkingCopyRegistry new 
			addWorkingCopy: store newWorkingCopy; 
			yourself).
	
	FiStoreBrowser new
		store: store;
		workingCopyRegistry: registry;
		plugin: plugin;
		refresh;
		openWithSpec;
		yourself
]

{ #category : #examples }
FiImpactStoreBrowserPlugin class >> exampleYrupe [
	"
	self exampleYrupe.
	"

	self exampleFragileBaseProblemWith: (YrPharoMigrator example1readTag: '30014') asArray
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> browseCritics [

	backgroundExecutor spawnNewProcessWith: [ 
		| rbEnvironment |
		rbEnvironment :=
			(FiRBBrowserEnvironment new 
				environment: self selectedEnvironment)
				forClasses: self selectedPackage definedClasses.

	self flag: #todo. "Extension methods are not included!"

		FiLintRulesBrowser exampleOn: rbEnvironment.
		]
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> browseInEnvironment [

	FiImpactRGEnvironmentBrowser openOn: self selectedEnvironment

]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> environmentFor: aHistoryNode [

	^ environmentByHistoryNode 
		at: aHistoryNode
		ifAbsentPut: [
			(environmentalPackages copyWith: aHistoryNode snapshot) asFiSet asFiRGEnvironment ]
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> environmentalPackages: aCollection [ 

	environmentalPackages := aCollection 
]

{ #category : #initialization }
FiImpactStoreBrowserPlugin >> initialize [

	super initialize.
	
	environmentByHistoryNode := Dictionary new.
	
	backgroundExecutor := FiExclusiveExecutor new.

]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> prepareHistoryNodeMenu: aMenu [

	aMenu addGroup: [:aGroup | 
		aGroup addItem: [:anItem | 
			anItem 
				name: 'Browse in environment';
				action: [ self browseInEnvironment ] ].
		aGroup addItem: [:anItem | 
			anItem 
				name: 'Browse critics in environment';
				action: [ self browseCritics ] ].
		]
]

{ #category : #private }
FiImpactStoreBrowserPlugin >> refresh [

	| env dependencies |
	self flag: #todo. "now unused. See version 62."

	env := selectedHistoryNode snapshot asFiRGEnvironment.

	dependencies := env ficusDependenciesForRedoing: selectedEffect.

	dependencies do: [ :dep |
		| pathsToDependencies |
		pathsToDependencies := dep targets collect: #ficusPathFromEnvironment.
			
		pathsToDependencies do: [ :path | 
			(dependenciesByHistoryNode 
				at: (selectedHistoryNode mostRecentHistoryNodeChanging: path)
				ifAbsentPut: [ Set new ])
				add: path ] .

"		dependenciesByHistoryNode associations 
			collect: #asString
			thenDo: #logCr."
	].

	self logCr: 'dependencies plugin refreshed'.
	self announceRefreshed.
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> selectedEnvironment [

	^ self environmentFor: selectedHistoryNode
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> selectedHistoryNodes: historyNodes [

	historyNodes ifEmpty: [ 
		selectedHistoryNode := nil.
		^ self ].

	self assert: historyNodes size = 1.

	selectedHistoryNode := historyNodes anyOne.
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> selectedPackage [

	self assert: selectedHistoryNode snapshot class = FiPackage.

	^ self selectedEnvironment packages detect: [:each | 
		each name = selectedHistoryNode snapshot name ]
]
