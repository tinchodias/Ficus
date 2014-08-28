Class {
	#name : #FiEpiceaHistoryBuilder,
	#superclass : #Object,
	#instVars : [
		'log',
		'packageName'
	],
	#category : #FicusEpicea
}

{ #category : #examples }
FiEpiceaHistoryBuilder class >> forFuelTestsCached [

	^ self new
		theLog: EpMonitor current log;
		packageName: 'FuelTests';
		yourself
]

{ #category : #examples }
FiEpiceaHistoryBuilder class >> forTetrisCached [

	^ self new
		theLog: EpMonitor current log;
		packageName: 'Tetris';
		yourself
]

{ #category : #accessing }
FiEpiceaHistoryBuilder >> browse [

	| initialHistoryNodes browser |
	1halt.
	initialHistoryNodes := FiEpiceaHistoryBuilder forTetrisCached historyNodes.

	browser := FiFullHistoryBrowser new
		notes: #();
		historyNodes: initialHistoryNodes;
		yourself.

	log announcer weak
		when: EpEntryAdded
		send: #entryAdded:
		to: self.
		
	^ browser 
		openWithSpec;
		yourself
]

{ #category : #private }
FiEpiceaHistoryBuilder >> historyNodeFor: anEntry prior: priorHistoryNode [
	
	| origin |		
	origin := FiSingleCommit builder reference: (log referenceTo: anEntry); new.

	^ FiSnapshotHistoryNode builder
		origin: origin;
		snapshot: (self snapshotFor: anEntry content prior: priorHistoryNode);
		priors: (FiSet withValues: { priorHistoryNode });
		new
]

{ #category : #accessing }
FiEpiceaHistoryBuilder >> historyNodes [
	
	| result |
	result := OrderedCollection withAll: (FiMonticelloHistoryBuilder forCachedPackageNamed: packageName) historyNodes.
	
	self interestingEntries reverseDo: [ :anEntry |
		result addLast: (self historyNodeFor: anEntry prior: result last) ].
	
	^ result
]

{ #category : #private }
FiEpiceaHistoryBuilder >> interestingEntries [
	
	| result |
	result := OrderedCollection new.

	log priorEntriesFromHeadDo: [ :entry |
		(self isInterestingCodeChange: entry)
			ifTrue: [ result add: entry ].
			
		(self isInterestingMCLoad: entry)
			ifTrue: [ ^ result ] ].
	
	^ result
]

{ #category : #private }
FiEpiceaHistoryBuilder >> isCodeChange: entry [

	^ entry content isKindOf: EpCodeChange
]

{ #category : #private }
FiEpiceaHistoryBuilder >> isInterestingCodeChange: entry [
	
	^ (self isCodeChange: entry) and: [ 
		(self isInterestingPackage: entry) and: [ 
			(self isTriggeredByMonticelloLoad: entry) not ] ]
]

{ #category : #private }
FiEpiceaHistoryBuilder >> isInterestingMCLoad: entry [

	^ (entry content isKindOf: EpMonticelloVersionsLoad) and: [ 
		entry content packageNames includes: packageName ]
]

{ #category : #private }
FiEpiceaHistoryBuilder >> isInterestingPackage: entry [
	
	^ entry content affectedPackageName = packageName
]

{ #category : #private }
FiEpiceaHistoryBuilder >> isTriggeredByMonticelloLoad: entry [

	entry tags 
		at: #trigger
		ifPresent: [ :triggerReference |
			log
				entryFor: triggerReference
				ifPresent:[ :triggerEntry | 
					^ triggerEntry content isKindOf: EpMonticelloVersionsLoad ]
				ifAbsent: [  ] ].

	^ false
]

{ #category : #accessing }
FiEpiceaHistoryBuilder >> packageName: anObject [
	
	packageName := anObject
]

{ #category : #private }
FiEpiceaHistoryBuilder >> snapshotFor: anEpCodeChange prior: priorHistoryNode [

	^ anEpCodeChange accept: (FiEpiceaTranslator newWithPrior: priorHistoryNode)
]

{ #category : #accessing }
FiEpiceaHistoryBuilder >> theLog: anObject [
	
	log := anObject
]
