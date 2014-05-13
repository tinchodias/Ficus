Class {
	#name : #FiMonticelloVersionGraphBuilder,
	#superclass : #Object,
	#instVars : [
		'repository',
		'packageName',
		'nodeByVersionName'
	],
	#category : #'FicusMonticello-Graph'
}

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtFuelConfigurationOfFuelExample [
	"
	self builtFuelConfigurationOfFuelExample.
	"

	^ self new
		repository: self fuelRepository;
		packageName: 'ConfigurationOfFuel';
		build
]

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtFuelExample [
	"
	self builtFuelExample.
	"

	^ self new
		repository: self fuelRepository;
		packageName: 'Fuel';
		build 
]

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtFuelTestsExample [
	"
	self builtFuelTestsExample.
	"

	^ self new
		repository: self fuelRepository;
		packageName: 'FuelTests';
		build 
]

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtNativeBoostCoreExample [
	"
	self builtNativeBoostCoreExample.
	"

	^ self new
		repository: self nativeBoostRepository;
		packageName: 'NativeBoost-Core';
		build 
]

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtPharoMorphicBaseExample [
	"
	self builtPharoMorphicBaseExample.
	"

	^ self new
		repository: self pharo30Repository;
		packageName: 'Morphic-Base';
		build 
]

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtPharoNativeBoostCoreExample [
	"
	self builtPharoNativeBoostCoreExample.
	"

	^ self new
		repository: self pharo30Repository;
		packageName: 'NativeBoost-Core';
		build 
]

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtSeaside30Example [
	"
	self builtSeaside30Example.
	"

	^ self new
		repository: self seaside30Repository;
		packageName: 'Seaside-Core';
		build 
]

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtSqueakMonticelloExample [
	"
	self builtSqueakMonticelloExample.
	"

	^ self new
		repository: self squeakRepository;
		packageName: 'Monticello';
		build 
]

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtSqueakMorphicExample [
	"
	self builtSqueakMorphicExample.
	"

	^ self new
		repository: self squeakRepository;
		packageName: 'Morphic';
		build
]

{ #category : #examples }
FiMonticelloVersionGraphBuilder class >> builtStonCoreExample [
	"
	self builtStonCoreExample.
	"

	^ self new
		repository: self stonRepository;
		packageName: 'STON-Tests';
		build
]

{ #category : #'examples-private' }
FiMonticelloVersionGraphBuilder class >> epiceaRepository [
	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/MartinDias/Epicea/main'
		user: ''
		password: ''
]

{ #category : #'examples-private' }
FiMonticelloVersionGraphBuilder class >> fuelRepository [
	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Fuel/main'
		user: ''
		password: ''
]

{ #category : #'examples-private' }
FiMonticelloVersionGraphBuilder class >> nativeBoostRepository [
	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/NativeBoost/main'
		user: ''
		password: ''
]

{ #category : #'examples-private' }
FiMonticelloVersionGraphBuilder class >> pharo30Repository [
	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo30/main'
		user: ''
		password: ''
]

{ #category : #'examples-private' }
FiMonticelloVersionGraphBuilder class >> seaside30Repository [
	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Seaside/Seaside30/main'
		user: ''
		password: ''
]

{ #category : #'examples-private' }
FiMonticelloVersionGraphBuilder class >> squeakRepository [
	^ MCHttpRepository
		location: 'http://source.squeak.org/trunk'
		user: ''
		password: ''
]

{ #category : #'examples-private' }
FiMonticelloVersionGraphBuilder class >> stonRepository [
	^ MCHttpRepository
		location: 'http://ss3.gemstone.com/ss/STON'
		user: ''
		password: ''
]

{ #category : #building }
FiMonticelloVersionGraphBuilder >> build [

	self updateFromRepositoryVersionNames.
	self loadRemainingVersionInfos.

]

{ #category : #accessing }
FiMonticelloVersionGraphBuilder >> buildAndBrowse [
	self build.
	self browse.
]

{ #category : #initialization }
FiMonticelloVersionGraphBuilder >> initialize [
	super initialize.
	
	nodeByVersionName := Dictionary new.
]

{ #category : #accessing }
FiMonticelloVersionGraphBuilder >> leafNodes [
	
	^ self nodes select: [ :each | each children isEmpty ]
]

{ #category : #accessing }
FiMonticelloVersionGraphBuilder >> loadRemainingVersionInfos [
	| currentNodes counter |
	currentNodes := self sortedNodes.
	counter := 25.

	[ counter > 0 and: [ currentNodes anySatisfy: [ :each | each versionInfo isNil ] ] ] whileTrue: [
		| nextNameToLoad packageInfo ancestry |
		counter := counter - 1.
		
		nextNameToLoad := (currentNodes reversed detect: [ :each | each versionInfo isNil ]) name.
		
		packageInfo := self packageInfoFor: nextNameToLoad. 
		ancestry := self recursiveAncestryFrom: packageInfo.
		
		self logCr: counter asString, '. Loading ', packageInfo name.
		
		self updateNodesFrom: ancestry.
		
		currentNodes := self sortedNodes.	
		].
]

{ #category : #private }
FiMonticelloVersionGraphBuilder >> nodeForVersionInfo: aVersionInfo [
	| node |
	node := nodeByVersionName 
		at: aVersionInfo name
		ifAbsentPut: [ FiMonticelloVersionNode for: aVersionInfo ].
	
	node versionInfo: aVersionInfo.
	
	^ node
]

{ #category : #private }
FiMonticelloVersionGraphBuilder >> nodeForVersionInfoNamed: aName [
	^ nodeByVersionName 
		at: aName
		ifAbsentPut: [ FiMonticelloVersionNode named: aName ]
]

{ #category : #accessing }
FiMonticelloVersionGraphBuilder >> nodes [ 
	^ nodeByVersionName values
]

{ #category : #private }
FiMonticelloVersionGraphBuilder >> packageInfoFor: versionName [
	"FIX: this makes some assumptions on the repository"
	
	^ repository versionInfoFromFileNamed: versionName, '.mcz'
]

{ #category : #accessing }
FiMonticelloVersionGraphBuilder >> packageName: aString [ 
	packageName := aString
]

{ #category : #private }
FiMonticelloVersionGraphBuilder >> recursiveAncestryFrom: aVersionInfo [
	| pendingVersionInfos collectedPackageInfos |
	pendingVersionInfos := OrderedCollection with: aVersionInfo.
	collectedPackageInfos := OrderedCollection new.

	[ pendingVersionInfos isEmpty ] whileFalse: [ 
		| currentVersionInfo |
		currentVersionInfo := pendingVersionInfos removeFirst.

		(collectedPackageInfos includes: currentVersionInfo) ifFalse: [
			collectedPackageInfos addFirst: currentVersionInfo.
			pendingVersionInfos addAllLast: currentVersionInfo ancestors ] ].

	^ collectedPackageInfos
]

{ #category : #accessing }
FiMonticelloVersionGraphBuilder >> repository: aMCRepository [ 
	repository := aMCRepository
]

{ #category : #accessing }
FiMonticelloVersionGraphBuilder >> repositoryVersionNames [

	| expectedBegin |
	expectedBegin := packageName, '-'.
	
	^ repository allVersionNames select: [ :each | each beginsWith: expectedBegin ]
]

{ #category : #accessing }
FiMonticelloVersionGraphBuilder >> sortedNodes [
	^ self nodes asSortedCollection: [ :a :b |
		(a name copyAfterLast: $.) asNumber <= 
			(b name copyAfterLast: $.) asNumber ]
]

{ #category : #private }
FiMonticelloVersionGraphBuilder >> updateFromRepositoryVersionNames [
	| repositoryVersionNames |
	repositoryVersionNames := self repositoryVersionNames.

	"just caching"
	repositoryVersionNames do: [ :each | self nodeForVersionInfoNamed: each ]
]

{ #category : #private }
FiMonticelloVersionGraphBuilder >> updateNodesFrom: packageInfos [
	"FIX: completely inefficient "

	packageInfos reverseDo: [ :each |
		| ancestorNodes |
		ancestorNodes := each ancestors collect: [ :ancestorPackageInfo | 
			self nodeForVersionInfo: ancestorPackageInfo ].	
		
		(self nodeForVersionInfo: each) ancestors: ancestorNodes ].
]
