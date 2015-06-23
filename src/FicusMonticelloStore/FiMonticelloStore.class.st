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
