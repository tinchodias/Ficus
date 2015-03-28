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
		'backgroundExecutor'
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

{ #category : #accessing }
FiImpactStoreBrowserPlugin >> browseInEnvironment [

	selectedHistoryNode snapshot asFiRGEnvironment browse
]

{ #category : #private }
FiImpactStoreBrowserPlugin >> dependenciesFor: aHistoryNode [ 

	^ dependenciesByHistoryNode 
		at: aHistoryNode
		ifAbsent: [ #() ]
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
FiImpactStoreBrowserPlugin >> prepareHistoryNodeDescriptionMorphs: morphs for: aHistoryNode [

	| dependencies icon button |
	aHistoryNode isWorkingCopy ifTrue: [ ^ self ].

	dependencies := self dependenciesFor: aHistoryNode.

	icon := 
		FiMorphBuilder default 
			tagWith: '# deps: ', dependencies size asString
			backgroundColor: Color blue muchLighter muchLighter
			fontColor: Color black.

	button := IconicButton new 
		target: self;
"		actionSelector: #browseComments:;
		arguments: { aHistoryNode };"
		labelGraphic: icon imageForm;
		color: Color transparent;
		helpText: dependencies asString;
		borderWidth: 0.
		
	morphs add: icon
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
