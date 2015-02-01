Class {
	#name : #FiEpiceaHistoryBuilder,
	#superclass : #Object,
	#instVars : [
		'log',
		'packageName',
		'headHistoryNode',
		'historyNodes'
	],
	#category : #FicusEpicea
}

{ #category : #private }
FiEpiceaHistoryBuilder >> compositeHistoryNodeFor: anEntry priors: priors and: aMonticelloHistoryNode [ 
	
	| epiceaOrigin monticelloOrigin |
	epiceaOrigin := FiSingleOrigin withReference: (log referenceTo: anEntry).
	monticelloOrigin := aMonticelloHistoryNode origin.

	^ FiSnapshotHistoryNode builder
		origin: (FiCompositeOrigin withOrigins: {epiceaOrigin. monticelloOrigin});
		snapshot: aMonticelloHistoryNode snapshot;
		priors: priors;
		new
]

{ #category : #private }
FiEpiceaHistoryBuilder >> editFor: anEpCodeChange [

	^ anEpCodeChange accept: (FiEpiceaTranslator newWithBasePath: FiPath root / #contents)
]

{ #category : #accessing }
FiEpiceaHistoryBuilder >> headHistoryNode [
	
	^ headHistoryNode
]

{ #category : #private }
FiEpiceaHistoryBuilder >> historyNodeFor: anEntry prior: priorHistoryNode [
	
	| origin |
	origin := FiSingleOrigin withReference: (log referenceTo: anEntry).

	^ FiDeltaHistoryNode builder
		origin: origin;
		edit: (self editFor: anEntry content);
		prior: priorHistoryNode;
		new
]

{ #category : #accessing }
FiEpiceaHistoryBuilder >> historyNodes [
	
	^ historyNodes
]

{ #category : #initialization }
FiEpiceaHistoryBuilder >> initialize [

	super initialize.
	
	historyNodes := OrderedCollection new.
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
		entry content packageName = packageName and: [
		entry content repositoryDescription beginsWith: '/' ] ] "FIX: workaround to reject saves to local"
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
FiEpiceaHistoryBuilder >> run [
	
	| mcNodes interestingEntries |
	interestingEntries := self interestingEntries.
	self assert: interestingEntries isNotEmpty.
	self assert: (self isInterestingMCLoad: interestingEntries last).

	mcNodes := (FiMonticelloStore forPackageNamed: packageName) historyNodes.
	
	interestingEntries reverseDo: [ :anEntry |

		"LOAD"
		(self isInterestingMCLoad: anEntry) ifTrue: [ 
			| mcNode | 
			self assert: anEntry content versionNames size = 1.

			mcNode := 
				mcNodes detect: [ :each | 
					each origin shortDescription = anEntry content versionNames anyOne ].

			historyNodes
				addAll: (mcNodes readStream upTo: mcNode); "Append mc nodes first"
				addLast:
					(self 
						compositeHistoryNodeFor: anEntry 
						priors: mcNode priors 
						and: mcNode).
			 ].

		"SAVE"
		(self isInterestingMCSave: anEntry) ifTrue: [ 
			| mcNode translatedMcPriors | 
			mcNode := 
				mcNodes detect: [ :each | 
					each origin shortDescription = anEntry content versionName ].

			translatedMcPriors := mcNode priors asArray collect: [ :aNodeToTranslate |
				| translatedNodes |
				translatedNodes := historyNodes select: [ :aCandidateNode | aCandidateNode origin contains: aNodeToTranslate origin ].
				translatedNodes size = 1 ifFalse: [ self inform: (self class name, ': multiple candidates for ', aNodeToTranslate asString) ].
				translatedNodes last ].

			historyNodes addLast:
				(self 
					compositeHistoryNodeFor: anEntry 
					priors: ({ historyNodes last } "it's the prior for epicea history", translatedMcPriors) asFiSet
					and: mcNode) ].

		"EPICEA CODE CHANGE"
		(self isInterestingCodeChange: anEntry) ifTrue: [ 
			historyNodes addLast: (self historyNodeFor: anEntry prior: historyNodes last) ].
		
		 ].
	
	headHistoryNode := historyNodes last.
]

{ #category : #accessing }
FiEpiceaHistoryBuilder >> theLog: anObject [
	
	log := anObject
]
