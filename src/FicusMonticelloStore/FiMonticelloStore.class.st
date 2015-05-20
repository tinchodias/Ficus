Class {
	#name : #FiMonticelloStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'packageName',
		'historyNodes',
		'repository'
	],
	#category : #FicusMonticelloStore
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
	versionNames := anMCHttpRepository allFileNamesOrCache 
		select: [ :each | each endsWith: '.mcz' ].
	
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

	{ self pharo20GemstoneRepository. self pharo10Repository. self pharo14Repository. self pharo20Repository. self pharo30Repository. self pharo40Repository } 
		do: [ :aRepository | self downloadToCacheAllFrom: aRepository ]
]

{ #category : #utility }
FiMonticelloStore class >> downloadToCacheFuelTests [

	{ self fuelRepository. self pharo30InboxRepository. self pharo30Repository } 
		do: [ :aRepository |
			self downloadToCache: #FuelTests from: aRepository ]
]

{ #category : #utility }
FiMonticelloStore class >> downloadToCachePharo20Gemstone [
	"
	self downloadToCachePharo20Gemstone
	"

	self downloadToCacheAllFrom: self pharo20GemstoneRepository
]

{ #category : #utility }
FiMonticelloStore class >> downloadToCachePharo20andPharo30 [
	"
	self downloadToCachePharo20andPharo30
	"

	{ self pharo20GemstoneRepository. self pharo20Repository. self pharo30Repository } 
		do: [ :aRepository |
			self downloadToCacheAllFrom: aRepository ]
]

{ #category : #example }
FiMonticelloStore class >> example [
	"Note: this assumes that there are versions of cahce of Tetris package."

	^ FiMonticelloStore forPackageNamed: #Tetris
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
FiMonticelloStore class >> pharo20GemstoneRepository [

	^ MCHttpRepository
		location: 'http://ss3.gemstone.com/ss/Pharo20'
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
FiMonticelloStore >> commitSnapshot: aSnapshot priors: priors [

	| monticelloWorkingCopy monticelloSnapshot newVersion |
	self assert: (aSnapshot isKindOf: FiPackage).
	
	monticelloWorkingCopy := MCWorkingCopy new.
	monticelloWorkingCopy initializeWithPackage: (MCPackage named: packageName).
	monticelloSnapshot := FiMonticelloReader new read: aSnapshot.

	priors do: [	 :each |
		monticelloWorkingCopy ancestry addAncestor: each origin reference ].
	
	newVersion := monticelloWorkingCopy
		silentlyNewVersionIn: self repository
		snapshot: monticelloSnapshot.

	newVersion ifNil: [ ^ self ].

	self repository storeVersion: newVersion.
	
	self refresh.
	^ self headHistoryNode.

]

{ #category : #accessing }
FiMonticelloStore >> historyNodes [

	self ensureReady.

	^ historyNodes
]

{ #category : #testing }
FiMonticelloStore >> isReady [

	^ historyNodes isNotNil
]

{ #category : #private }
FiMonticelloStore >> monticelloVersionFor: aVersionName [
		
	^ (self repository versionFromFileNamed: (aVersionName, '.mcz'))
		ifNil: [ self error ]

]

{ #category : #accessing }
FiMonticelloStore >> name [

	^ self packageName
]

{ #category : #accessing }
FiMonticelloStore >> packageName [

	^ packageName
]

{ #category : #accessing }
FiMonticelloStore >> packageName: anObject [

	packageName := anObject 
]

{ #category : #refreshing }
FiMonticelloStore >> refresh [

	| builder |
	builder := FiMonticelloHistoryBuilder 
		forTipsOfPackageNamed: packageName
		repository: self repository.

	historyNodes := builder historyNodes.
]

{ #category : #accessing }
FiMonticelloStore >> repository [
			
	^ repository ifNil: [ 
		repository := MCCacheRepository uniqueInstance ]
]

{ #category : #accessing }
FiMonticelloStore >> repository: aMCRepository [
	
	repository := aMCRepository
]
