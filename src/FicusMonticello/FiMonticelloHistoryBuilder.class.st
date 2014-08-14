Class {
	#name : #FiMonticelloHistoryBuilder,
	#superclass : #Object,
	#instVars : [
		'repository',
		'pendingVersionInfos',
		'historyNodeByUUID',
		'notFoundVersions',
		'historyNodes'
	],
	#category : #'FicusMonticello-Marshaling-New'
}

{ #category : #examples }
FiMonticelloHistoryBuilder class >> forFuelTests [

	| repositoryGroup initialVersionInfo fuelRepository pharoInboxRepository pharoRepository |
	fuelRepository := self fuelRepository.
	pharoInboxRepository := self pharo30InboxRepository.
	pharoRepository := self pharo30Repository.

	repositoryGroup := 
		MCRepositoryGroup withRepositories: {
			fuelRepository.
			pharoInboxRepository.
			pharoRepository }.

	initialVersionInfo := 
		(MCWorkingCopy allManagers 
			detect: [ :each | each packageName = 'FuelTests' ]) 
			ancestry ancestors first.
	
	fuelRepository cacheAllFileNamesDuring:	[
		pharoInboxRepository cacheAllFileNamesDuring: [
			pharoRepository cacheAllFileNamesDuring: [
				^ self new
					repository: repositoryGroup;
					addVersionInfo: initialVersionInfo;
					run;
					yourself ] ] ]
		
]

{ #category : #examples }
FiMonticelloHistoryBuilder class >> forFuelTestsCached [

	| repositoryGroup initialVersionInfo cachedRepository |
	cachedRepository := MCCacheRepository uniqueInstance.

	repositoryGroup := 
		MCRepositoryGroup withRepositories: {
			cachedRepository }.

	initialVersionInfo := 
		(MCWorkingCopy allManagers 
			detect: [ :each | each packageName = 'FuelTests' ]) 
			ancestry ancestors first.
	
	cachedRepository cacheAllFileNamesDuring:	[
		^ self new
			repository: repositoryGroup;
			addVersionInfo: initialVersionInfo;
			run;
			yourself ]
]

{ #category : #'examples-private' }
FiMonticelloHistoryBuilder class >> fuelRepository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Fuel/main'
		user: ''
		password: ''
]

{ #category : #'examples-private' }
FiMonticelloHistoryBuilder class >> pharo30InboxRepository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo30Inbox/main'
		user: ''
		password: ''
]

{ #category : #'examples-private' }
FiMonticelloHistoryBuilder class >> pharo30Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo30/main'
		user: ''
		password: ''
]

{ #category : #accessing }
FiMonticelloHistoryBuilder >> addVersionInfo: aMCVersionInfo [ 

	pendingVersionInfos push: aMCVersionInfo 
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
	
	mcSnapshot := (repository 
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
				origin: ((FiSingleCommit builder reference: versionInfo; new) followedBy: priorNodeToMerge origin);
				snapshot: ficusPackage;
				priors: priorNodeToMerge priors;
				new.

				self flag: #fix. "ugly code"
				
				priorNodeToMerge becomeForward: node.
				historyNodeByUUID rehash ]
		ifFalse: [
			node := FiSnapshotHistoryNode builder
				origin: (FiSingleCommit builder reference: versionInfo; new);
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
FiMonticelloHistoryBuilder >> repository: aMCRepository [

	repository := aMCRepository
]

{ #category : #running }
FiMonticelloHistoryBuilder >> run [

	[ pendingVersionInfos isEmpty ] whileFalse: [  
		| aVersionInfo |
		aVersionInfo := pendingVersionInfos pop.

		self historyNodeFor: aVersionInfo.
		 ] 
]
