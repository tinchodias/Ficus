"
I'm a plugin that shows dependency nformation into the browser.
"
Class {
	#name : #RFiImpactStoreBrowserPlugin,
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
RFiImpactStoreBrowserPlugin class >> example [
	"
	self example.
	"

	self exampleFragileBaseProblemWith: RFiBaseResources new ficusEnvironment asArray
]

{ #category : #examples }
RFiImpactStoreBrowserPlugin class >> exampleFragileBaseProblemWith: environmentalPackages [

	^ self 
		exampleWith: FiMemoryStore exampleFragileBaseProblemOnlyPackage
		and: environmentalPackages
]

{ #category : #examples }
RFiImpactStoreBrowserPlugin class >> exampleWith: store and: environmentalPackages [

	| registry plugin |
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
RFiImpactStoreBrowserPlugin class >> exampleYrupe [
	"
	self exampleYrupe.
	"

	self exampleFragileBaseProblemWith: (YrPharoMigrator example1readTag: '30014') asArray
]

{ #category : #examples }
RFiImpactStoreBrowserPlugin class >> exampleYrupeAllPharos [
	"
	[self exampleYrupeAllPharos] timeToRun.
	"
	
	| pharos |
	pharos := YrPharoMigrator example1tags collect: [ :tag |
		(YrPharoMigrator example1readTag: tag) ].

	^ self exampleWith: (FiMemoryStore exampleWithAll: pharos) and: #()
]

{ #category : #examples }
RFiImpactStoreBrowserPlugin class >> exampleYrupeChoosing [

	| tags result env |
	tags := YrPharoMigrator example1tags.

	result := UIManager default
		chooseFrom: tags 
		title: 'Select a Pharo version'.
		
	result isZero ifTrue: [ ^ self ].

	env := YrPharoMigrator example1readTag: (tags at: result).

	^ self exampleFragileBaseProblemWith: env asArray
]

{ #category : #examples }
RFiImpactStoreBrowserPlugin class >> exampleYrupeManyPharos [
	"
	[self exampleYrupeManyPharos] timeToRun.
	"
	
	| pharos |
	pharos := (YrPharoMigrator example1tags first: 125) collect: [ :tag |
		(YrPharoMigrator example1readTag: tag) ].

	^ self exampleWith: (FiMemoryStore exampleWithAll: pharos) and: #()
]

{ #category : #accessing }
RFiImpactStoreBrowserPlugin >> browseCritics [

	backgroundExecutor spawnNewProcessWith: [ 
		| rbEnvironment |
		rbEnvironment :=
			(FiRBBrowserEnvironment new 
				environment: self selectedEnvironment)
				forClasses: self selectedPackage definedClasses.

	self flag: #todo. "Extension methods are not included!"

		RFiLintRulesBrowser exampleOn: rbEnvironment.
		]
]

{ #category : #accessing }
RFiImpactStoreBrowserPlugin >> browseInEnvironment [

	RFiImpactRGEnvironmentBrowser openOn: self selectedEnvironment

]

{ #category : #accessing }
RFiImpactStoreBrowserPlugin >> environmentFor: aHistoryNode [

	^ environmentByHistoryNode 
		at: aHistoryNode
		ifAbsentPut: [
			(environmentalPackages, aHistoryNode snapshot) asFiSet asRFiEnvironment ]
]

{ #category : #accessing }
RFiImpactStoreBrowserPlugin >> environmentalPackages: aCollection [ 

	environmentalPackages := aCollection 
]

{ #category : #initialization }
RFiImpactStoreBrowserPlugin >> initialize [

	super initialize.
	
	environmentByHistoryNode := Dictionary new.
	
	backgroundExecutor := RFiExclusiveExecutor new.

]

{ #category : #accessing }
RFiImpactStoreBrowserPlugin >> prepareHistoryNodeMenu: aMenu [

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
RFiImpactStoreBrowserPlugin >> refresh [

	| env dependencies |
	self flag: #todo. "now unused. See version 62."

	env := selectedHistoryNode snapshot asRFiEnvironment.

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
RFiImpactStoreBrowserPlugin >> selectedEnvironment [

	^ self environmentFor: selectedHistoryNode
]

{ #category : #accessing }
RFiImpactStoreBrowserPlugin >> selectedHistoryNodes: historyNodes [

	historyNodes ifEmpty: [ 
		selectedHistoryNode := nil.
		^ self ].

	self assert: historyNodes size = 1.

	selectedHistoryNode := historyNodes anyOne.
]

{ #category : #accessing }
RFiImpactStoreBrowserPlugin >> selectedPackage [

	self assert: selectedHistoryNode snapshot class = FiPackage.

	^ self selectedEnvironment packages detect: [:each | 
		each name = selectedHistoryNode snapshot name ]
]
