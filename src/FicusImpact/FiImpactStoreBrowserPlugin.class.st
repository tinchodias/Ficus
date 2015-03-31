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
		'environmentalPackages'
	],
	#category : #'FicusImpact-UI'
}

{ #category : #examples }
FiImpactStoreBrowserPlugin class >> example [
	"
	self example.
	"

	| store registry |
	store := FiMemoryStore exampleFragileBaseProblem.

	registry :=
		(FiWorkingCopyRegistry new 
			addWorkingCopy: store newWorkingCopy; 
			yourself).
		
	FiStoreBrowser new
		store: store;
		workingCopyRegistry: registry;
		plugin: self new;
		refresh;
		openWithSpec;
		yourself
]

{ #category : #examples }
FiImpactStoreBrowserPlugin class >> exampleYrupe [
	"
	self exampleYrupe.
	"

	| store environmentalPackages registry plugin |
	store := FiMemoryStore exampleFragileBaseProblemOnlyPackage.

	environmentalPackages := (YrPharoMigrator example1readTag: '30014') asArray.
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

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> browseInEnvironment [

	FiImpactRGEnvironmentBrowser openOn: 
		(self environmentFor: selectedHistoryNode snapshot)
]

{ #category : #private }
FiImpactStoreBrowserPlugin >> dependenciesFor: aHistoryNode [ 

	^ dependenciesByHistoryNode 
		at: aHistoryNode
		ifAbsent: [ #() ]
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> environmentFor: aPackage [

	^ (environmentalPackages copyWith: aPackage) asFiSet asFiRGEnvironment
]

{ #category : #'as yet unclassified' }
FiImpactStoreBrowserPlugin >> environmentalPackages: aCollection [ 

	environmentalPackages := aCollection 
]

{ #category : #initialization }
FiImpactStoreBrowserPlugin >> initialize [

	super initialize.
	
	backgroundExecutor := FiExclusiveExecutor new.
	
	self resetCache.
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> pinSelection [ 

	selectedEffect ifNil: [ 
		self resetCache.
		^ self ].
	
	backgroundExecutor spawnNewProcessWith: [ self refresh ].
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> prepareEffectMenu: aMenu [

	aMenu addGroup: [:aGroup | 
		aGroup addItem: [:anItem | 
			anItem 
				name: 'Pin for Dependency Analysis';
				description: '...';
"				icon: EpSorterView icon;"
				shortcut: $d command;
				action: [ self pinSelection ] ] ]
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> prepareHistoryNodeMenu: aMenu [

	aMenu addGroup: [:aGroup | 
		aGroup addItem: [:anItem | 
			anItem 
				name: 'Browse in environment';
				action: [ self browseInEnvironment ] ] ]
]

{ #category : #private }
FiImpactStoreBrowserPlugin >> refresh [

	| env dependencies |
	self resetCache.
		
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

{ #category : #private }
FiImpactStoreBrowserPlugin >> resetCache [

	dependenciesByHistoryNode := Dictionary new
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> selectedEffect: aSimpleEffectOrNil [

	selectedEffect = aSimpleEffectOrNil ifTrue: [ ^ self ].

	self logCr: 'selectedEffect: ', aSimpleEffectOrNil asString.

	selectedEffect := aSimpleEffectOrNil.
]

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> selectedHistoryNodes: historyNodes [

	self logCr: 'selectedHistoryNodes: ', historyNodes asString.

	historyNodes ifEmpty: [ 
		selectedHistoryNode := nil.
		^ self ].

	self assert: historyNodes size = 1.

	selectedHistoryNode := historyNodes anyOne.
]
