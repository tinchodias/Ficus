Class {
	#name : #FiMonticelloHistoryBuilder,
	#superclass : #Object,
	#instVars : [
		'pendingVersionInfos',
		'historyNodeByUUID',
		'notFoundVersions',
		'historyNodes',
		'repositoryGroup'
	],
	#category : #'FicusMonticello-Marshaling-HistoryNodes'
}

{ #category : #examples }
FiMonticelloHistoryBuilder class >> forTipsOfCachedPackageNamed: packageName [

	| repositoryGroup tipVersionInfos cachedRepository |
	cachedRepository := MCCacheRepository uniqueInstance.

	repositoryGroup := 
		MCRepositoryGroup withRepositories: {
			cachedRepository }.
	
	cachedRepository cacheAllFileNamesDuring:	[
		tipVersionInfos := self tipVersionInfosFor: packageName in: cachedRepository.

		^ self new
			repositoryGroup: repositoryGroup;
			addAllVersionInfos: tipVersionInfos;
			run;
			yourself ]
]

{ #category : #'examples-private' }
FiMonticelloHistoryBuilder class >> tipVersionInfosFor: aPackageName in: aRepository [

	| versionNames versionInfos sorter |
	versionNames := aRepository fileNamesForPackageNamed: aPackageName. 

	versionInfos := 
		versionNames 
			collect: [ :e | aRepository versionInfoFromFileNamed: e ] 
			thenReject: [ :e | e isNil ].

	sorter := MCVersionSorter new 
		addAllVersionInfos: versionInfos;
		sortedVersionInfos;
		yourself.

	^ sorter layers first
]

{ #category : #'examples-private' }
FiMonticelloHistoryBuilder class >> tipVersionInfosFor: aPackageName in: aRepository upTo: targetVersionInfo [

	| versionNames versionInfos sorter |
	versionNames := aRepository fileNamesForPackageNamed: aPackageName. 

	versionInfos := 
		versionNames 
			collect: [ :e | aRepository versionInfoFromFileNamed: e ] 
			thenReject: [ :e | e isNil ].

	sorter := MCFilteredVersionSorter new 
		target: targetVersionInfo;
		addAllVersionInfos: versionInfos;
		sortedVersionInfos;
		yourself.

	^ sorter layers first
]

{ #category : #accessing }
FiMonticelloHistoryBuilder >> addAllVersionInfos: aCollectionOfMCVersionInfo [ 

	aCollectionOfMCVersionInfo do: [ :each |
		self addVersionInfo: each ]
]

{ #category : #accessing }
FiMonticelloHistoryBuilder >> addVersionInfo: aMCVersionInfo [ 

	pendingVersionInfos push: aMCVersionInfo 
]

{ #category : #private }
FiMonticelloHistoryBuilder >> checkNoRepetitions [
	
	self 
		assert: historyNodes asSet size = historyNodes size 
		description: 'Integrity error in history: ', (historyNodes asBag valuesAndCounts associations select:[ :valueAndCount | valueAndCount value > 1 ]) asString
]

{ #category : #private }
FiMonticelloHistoryBuilder >> ficusPackageFor: mcSnapshot named: packageName [

	^ FiMonticelloMarshaler new marshaled: mcSnapshot name: packageName
]

{ #category : #private }
FiMonticelloHistoryBuilder >> historyNodeFor: aVersionInfo [
	
	| mcSnapshot versionInfo node priors ficusPackage |

	"Escape if already cached"	
	historyNodeByUUID 
		at: aVersionInfo id 
		ifPresent: [ :cached | ^ cached ].
	
	versionInfo := aVersionInfo.
	
	mcSnapshot := (repositoryGroup 
		versionWithInfo: aVersionInfo
		ifAbsent: [ notFoundVersions add: aVersionInfo. nil ]) 
		ifNotNil: [ :foundVersion | 
			versionInfo := foundVersion info. "The found version info could be more complete than the one used to search"
			foundVersion snapshot ]
		ifNil: [ MCSnapshot empty ].


	ficusPackage := self ficusPackageFor: mcSnapshot named: versionInfo packageName.
	priors := versionInfo ancestors collect: [ :each | self historyNodeFor: each ].

	"(priors size = 1 and: [ priors anyOne snapshot = ficusPackage ]) " false
		ifTrue: [ 
			| priorNodeToMerge |
			priorNodeToMerge := priors anyOne.
			node := FiSnapshotHistoryNode builder
				origin: ((FiSingleOrigin builder reference: versionInfo; new) followedBy: priorNodeToMerge origin);
				snapshot: ficusPackage;
				priors: priorNodeToMerge priors;
				new.

				self flag: #fix. "ugly code"
				
				priorNodeToMerge becomeForward: node.
				historyNodeByUUID rehash ]
		ifFalse: [
			node := FiSnapshotHistoryNode builder
				origin: (FiSingleOrigin builder reference: versionInfo; new);
				snapshot: ficusPackage;
				priors: (FiSet withValues: priors);
				new ].
			
	
	"do cache"	
	historyNodeByUUID 
		at: versionInfo id
		put: node.
		
	historyNodes add: node.
		
	^ node
]

{ #category : #accessing }
FiMonticelloHistoryBuilder >> historyNodes [

	^ historyNodes
]

{ #category : #initialization }
FiMonticelloHistoryBuilder >> initialize [

	super initialize.
	
	historyNodes := OrderedCollection new.
	pendingVersionInfos := Stack new.
	historyNodeByUUID := Dictionary new.
	notFoundVersions := Set new.
]

{ #category : #accessing }
FiMonticelloHistoryBuilder >> repositoryGroup: aMCRepositoryGroup [

	repositoryGroup := aMCRepositoryGroup
]

{ #category : #running }
FiMonticelloHistoryBuilder >> run [

	[ pendingVersionInfos isEmpty ] whileFalse: [  
		| aVersionInfo |
		aVersionInfo := pendingVersionInfos pop.

		self historyNodeFor: aVersionInfo.
		 ].
	
	self checkNoRepetitions.
]
