Class {
	#name : #FiMonticelloStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'packageName'
	],
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
FiMonticelloStore class >> downloadToCacheAllFrom: anMCHttpRepository [
	"
	self downloadToCacheAllFrom: (MCHttpRepository location: 'http://smalltalkhub.com/mc/maxi/Chalten/main')
	"

	| versionNames |
	versionNames := anMCHttpRepository allFileNamesOrCache.
	
	versionNames 
		do: [ :aFileName | 
			(MCCacheRepository uniqueInstance includesFileNamed: aFileName) ifFalse: [ 
				[ anMCHttpRepository readStreamForFileNamed: aFileName do: [ :e | ] ] 
					on: Error 
					do: [ "just retry once more" 
						anMCHttpRepository readStreamForFileNamed: aFileName do: [ :e | ] ]
			] ]
		displayingProgress: [ :aFileName | 'Downloading ', aFileName, ' (total: ', versionNames size asString, ')' ]
]

{ #category : #utility }
FiMonticelloStore class >> downloadToCacheAllPharoXX [
	"
	self downloadToCacheAllPharoXX
	"

	{ self pharo10Repository. self pharo14Repository. self pharo20Repository. self pharo30Repository. self pharo40Repository } 
		do: [ :aRepository | self downloadToCacheAllFrom: aRepository ]
]

{ #category : #utility }
FiMonticelloStore class >> downloadToCacheFuelTests [

	{ self fuelRepository. self pharo30InboxRepository. self pharo30Repository } 
		do: [ :aRepository |
			self downloadToCache: #FuelTests from: aRepository ]
]

{ #category : #utility }
FiMonticelloStore class >> downloadToCachePharo20andPharo30 [
	"
	self downloadToCachePharo20andPharo30
	"

	{ self pharo20Repository. self pharo30Repository } 
		do: [ :aRepository |
			self downloadToCacheAllFrom: aRepository ]
]

{ #category : #'instance creation' }
FiMonticelloStore class >> forPackageNamed: aString [ 

	^ self new
		packageName: aString;
		yourself
]

{ #category : #private }
FiMonticelloStore class >> fuelRepository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Fuel/main'
		user: ''
		password: ''
]

{ #category : #private }
FiMonticelloStore class >> pharo10Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo10/main'
		user: ''
		password: ''
]

{ #category : #private }
FiMonticelloStore class >> pharo14Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo14/main'
		user: ''
		password: ''
]

{ #category : #private }
FiMonticelloStore class >> pharo20Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo20/main'
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

{ #category : #private }
FiMonticelloStore class >> pharo40Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main'
		user: ''
		password: ''
]

{ #category : #accessing }
FiMonticelloStore >> packageName: anObject [

	packageName := anObject 
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
