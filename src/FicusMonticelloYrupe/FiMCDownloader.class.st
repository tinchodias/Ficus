Class {
	#name : #FiMCDownloader,
	#superclass : #Object,
	#category : #'FicusMonticelloYrupe-Migration'
}

{ #category : #repositories }
FiMCDownloader class >> CodeImporterRepository [

	^ MCSmalltalkhubRepository
		owner: 'Pharo'
		project: 'CodeImporter'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> FastTableRepository [

	^ MCSmalltalkhubRepository
		owner: 'estebanlm'
		project: 'FastTable'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> GTToolsIntegrationRepository [

	^ MCSmalltalkhubRepository
			owner: 'PharoExtras'
			project: 'GTToolsIntegration'
			user: ''
			password: ''
]

{ #category : #repositories }
FiMCDownloader class >> GToolkitRepository [

	^ MCSmalltalkhubRepository
		owner: 'Moose'
		project: 'GToolkit'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> ShoreLineRepository [

	^ MCSmalltalkhubRepository
			owner: 'dalsat'
			project: 'ShoreLine-Reporter'
			user: ''
			password: ''
]

{ #category : #repositories }
FiMCDownloader class >> StonRepository [

	^ MCGemstoneRepository
		location: 'http://ss3.gemstone.com/ss/STON'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> VersionnerPharoExtrasRepository [

	^ MCSmalltalkhubRepository
		owner: 'PharoExtras'
		project: 'Versionner'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> ZodiacRepository [

	^ MCHttpRepository
		location: 'http://mc.stfx.eu/Zodiac'
		user: ''
		password: ''
]

{ #category : #utility }
FiMCDownloader class >> allRepositorySelectors [

	^ self classSide selectors select: [ :each | each endsWith: 'Repository' ]
]

{ #category : #repositories }
FiMCDownloader class >> asmJitRepository [

	^ MCSmalltalkhubRepository
		owner: 'Pharo'
		project: 'AsmJit'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> athensRepository [

	^ MCSmalltalkhubRepository
		owner: 'Pharo'
		project: 'Athens'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> catalogBrowserRepository [
	"Used in Pharo 50"

	^ MCSmalltalkhubRepository
			owner: 'PharoExtras'
			project: 'CatalogBrowser'
			user: ''
			password: ''
]

{ #category : #utility }
FiMCDownloader class >> downloadToCache: aPackageName from: anMCHttpRepository [
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
FiMCDownloader class >> downloadToCacheAllFrom: anMCHttpRepository [
	"
	self downloadToCacheAllFrom: self FastTableRepository
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
FiMCDownloader class >> downloadToCacheAllPharoXX [
	"
	self downloadToCacheAllPharoXX
	"

	{ self pharo10Repository. self pharo14Repository. self pharo20GemstoneRepository. self pharo20Repository. self pharo30Repository. self pharo40Repository. self pharo50Repository } 
		do: [ :aRepository | self downloadToCacheAllFrom: aRepository ]
]

{ #category : #utility }
FiMCDownloader class >> downloadToCacheAllRepositories [
	"
	self downloadToCacheAllRepositories
	"

	self allRepositorySelectors do: [ :each | 
		self downloadToCacheAllFrom: (self perform: each) ]
]

{ #category : #repositories }
FiMCDownloader class >> fuelRepository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Fuel/main'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> glamourRepository [

	^ MCSmalltalkhubRepository
		owner: 'Moose'
		project: 'Glamour'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> nativeBoostRepository [

	^ MCSmalltalkhubRepository
			owner: 'Pharo'
			project: 'NativeBoost'
			user: ''
			password: ''
]

{ #category : #repositories }
FiMCDownloader class >> oSWindowRepository [

	^ MCSmalltalkhubRepository
		owner: 'Pharo'
		project: 'OSWindow'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> opalRepository [

	^ MCSmalltalkhubRepository
		owner: 'Pharo'
		project: 'Opal'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> pharo10Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo10/main'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> pharo14Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo14/main'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> pharo20GemstoneRepository [

	^ MCHttpRepository
		location: 'http://ss3.gemstone.com/ss/Pharo20'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> pharo20Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo20/main'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> pharo30Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo30/main'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> pharo40Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> pharo50Repository [

	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo50/main'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> rubricRepository [

	^ MCSmalltalkhubRepository
		owner: 'Pharo'
		project: 'Rubric'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> txTextRepository [

	^ MCSmalltalkhubRepository
		owner: 'Pharo'
		project: 'TxText'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> verisonnerRepository [

	^ MCSmalltalkhubRepository
		owner: 'demarey'
		project: 'Versionner'
		user: ''
		password: ''
]

{ #category : #repositories }
FiMCDownloader class >> zincRepository [

	^ MCHttpRepository
		location: 'http://mc.stfx.eu/ZincHTTPComponents'
		user: ''
		password: ''
]
