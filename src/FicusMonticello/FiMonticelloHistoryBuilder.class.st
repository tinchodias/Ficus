Class {
	#name : #FiMonticelloHistoryBuilder,
	#superclass : #Object,
	#instVars : [
		'repository',
		'pendingVersionInfos',
		'historyNodeByUUID',
		'notFoundVersions'
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
	
	| mcSnapshot versionInfo node |

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

	node := FiSnapshotHistoryNode builder
		origin: versionInfo;
		snapshot: (self ficusPackageFor: mcSnapshot named: versionInfo packageName);
		priors: (FiSet withValues: (versionInfo ancestors collect: [ :each | self historyNodeFor: each ]));
		new.
	
	"do cache"	
	historyNodeByUUID 
		at: versionInfo id
		put: node.
		
	^ node
]

{ #category : #accessing }
FiMonticelloHistoryBuilder >> historyNodes [

	^ historyNodeByUUID values
]

{ #category : #initialization }
FiMonticelloHistoryBuilder >> initialize [

	super initialize.
	
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
