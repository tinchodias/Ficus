Class {
	#name : #FiMonticelloStore,
	#superclass : #FiAbstractStore,
	#category : #'FicusMonticello-Marshaling-HistoryNodes'
}

{ #category : #utility }
FiMonticelloStore class >> downloadToCache: aPackageName from: anMCHttpRepository [
	"
	self 
		downloadToCache: 'Chalten-Core' 
		from: (MCHttpRepository location: 'http://smalltalkhub.com/mc/maxi/Chalten/main')
	"

	| versionNames |
	versionNames := anMCHttpRepository fileNamesForPackageNamed: aPackageName.
	
	versionNames 
		do: [ :aFileName | 
			(MCCacheRepository uniqueInstance includesFileNamed: aFileName)
				ifFalse: [ anMCHttpRepository readStreamForFileNamed: aFileName do: [ :e | ] ] ]
		displayingProgress: [ 'Downloading ', aPackageName, ' (total: ', versionNames size asString, ')' ]
]

{ #category : #utility }
FiMonticelloStore class >> downloadToCacheFuelTests [

	{ self fuelRepository. self pharo30InboxRepository. self pharo30Repository } 
		do: [ :aRepository |
			self downloadToCache: #FuelTests from: aRepository ]
]

{ #category : #private }
FiMonticelloStore class >> fuelRepository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Fuel/main'
		user: ''
		password: ''
]

{ #category : #private }
FiMonticelloStore class >> pharo30InboxRepository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo30Inbox/main'
		user: ''
		password: ''
]

{ #category : #private }
FiMonticelloStore class >> pharo30Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo30/main'
		user: ''
		password: ''
]

{ #category : #refreshing }
FiMonticelloStore >> refresh [

	cachedHistoryNodes := (FiMonticelloHistoryBuilder forTipsOfCachedPackageNamed: packageName) historyNodes.
	
	cachedHeadHistoryNodes := 
		(MCWorkingCopy allManagers 
			detect: [ :each | each packageName = packageName ]
			ifFound: [ :aManager | 
				| headVersionInfo |
				headVersionInfo := aManager ancestry ancestors first.
				self flag: #fix. "Do not assume that origin si FiSingleCommit"
				cachedHistoryNodes 
					detect: [ :node | node origin reference = headVersionInfo ]
					ifNone: [ self notYetImplemented ] ]
			ifNone: [ self notYetImplemented ]).
]
