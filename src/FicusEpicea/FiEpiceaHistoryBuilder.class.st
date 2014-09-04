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
FiEpiceaHistoryBuilder class >> forErgoPlaygroundCached [

	^ self new
		theLog: EpMonitor current log;
		packageName: 'ErgoPlayground';
		yourself
]

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
FiEpiceaHistoryBuilder >> compositeHistoryNodeFor: anEntry priors: priors and: aMonticelloHistoryNode [ 
	
	| origin epiceaOrigin monticelloOrigin |
	epiceaOrigin := FiSingleCommit builder reference: (log referenceTo: anEntry); new.
	monticelloOrigin := aMonticelloHistoryNode origin.

	origin := 
		FiCompositeOrigin builder 
			origins: (FiSet withValues: {epiceaOrigin. monticelloOrigin});
			new.

	^ FiSnapshotHistoryNode builder
		origin: origin;
		snapshot: aMonticelloHistoryNode snapshot;
		priors: priors;
		new
]

{ #category : #private }
FiEpiceaHistoryBuilder >> editFor: anEpCodeChange [

	^ anEpCodeChange accept: (FiEpiceaTranslator newWithBasePath: FiPath root / #contents)
]

{ #category : #private }
FiEpiceaHistoryBuilder >> historyNodeFor: anEntry prior: priorHistoryNode [
	
	| origin             node |		
	origin := FiSingleCommit builder reference: (log referenceTo: anEntry); new.

	node := FiPatchHistoryNode builder
		origin: origin;
		edit: (self editFor: anEntry content);
		prior: priorHistoryNode;
		new.
		
	Halt if: [ node printString = 'a FiPatchHistoryNode(a FiSingleCommit(an OmReference(Yrupe-505-Mix-1_2vzn6fh:47)))' ].

	^ node
]

{ #category : #accessing }
FiEpiceaHistoryBuilder >> historyNodes [
	
	| mcNodes result interestingEntries |
	interestingEntries := self interestingEntries.
	self assert: interestingEntries isNotEmpty.
	self assert: (self isInterestingMCLoad: interestingEntries last).

	mcNodes := (FiMonticelloHistoryBuilder forCachedPackageNamed: packageName) historyNodes.
	result := OrderedCollection new.
	
	interestingEntries reverseDo: [ :anEntry |

		"LOAD"
		(self isInterestingMCLoad: anEntry) ifTrue: [ 
			| mcNode | 
			self assert: anEntry content versionNames size = 1.

			mcNode := 
				mcNodes detect: [ :each | 
					each origin shortDescription = anEntry content versionNames anyOne ].

			result 
				addAll: (mcNodes readStream upTo: mcNode); "Append mc nodes first"
				addLast:
					(self 
						compositeHistoryNodeFor: anEntry 
						priors: mcNode priors 
						and: mcNode)
			].

		"SAVE"
		(self isInterestingMCSave: anEntry) ifTrue: [ 
			| mcNode translatedMcPriors | 
			mcNode := 
				mcNodes detect: [ :each | 
					each origin shortDescription = anEntry content versionName ].

			translatedMcPriors := mcNode priors asArray collect: [ :aNodeToTranslate |
				| translatedNodes |
				translatedNodes := result select: [ :aCandidateNode | aCandidateNode origin contains: aNodeToTranslate origin ].
				self assert: translatedNodes size = 1.
				translatedNodes anyOne ].

			result addLast:
				(self 
					compositeHistoryNodeFor: anEntry 
					priors: (FiSet withValues: ({ result last } "it's the prior for epicea history", translatedMcPriors))
					and: mcNode) ].

		"EPICEA CODE CHANGE"
		(self isInterestingCodeChange: anEntry) ifTrue: [ 
			result addLast: (self historyNodeFor: anEntry prior: result last) ].
		
		 ].
	
	^ result
]

{ #category : #private }
FiEpiceaHistoryBuilder >> interestingEntries [
	
	| result |
	result := OrderedCollection new.

	log priorEntriesFromHeadDo: [ :entry |
		((self isInterestingCodeChange: entry) 
			or: [ (self isInterestingMCLoad: entry) 
			or: [ self isInterestingMCSave: entry ]])
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
FiEpiceaHistoryBuilder >> isInterestingMCSave: entry [

	^ (entry content isKindOf: EpMonticelloVersionSave) and: [ 
		entry content packageName = packageName ]
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

{ #category : #accessing }
FiEpiceaHistoryBuilder >> theLog: anObject [
	
	log := anObject
]
