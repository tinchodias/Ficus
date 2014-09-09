Class {
	#name : #FiEpiceaStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'theLog'
	],
	#category : #FicusEpicea
}

{ #category : #refreshing }
FiEpiceaStore >> refresh [

	| historyBuilder |
	historyBuilder := 
		FiEpiceaHistoryBuilder new 
			packageName: packageName;
			theLog: self theLog;
			run;
			yourself. 

	cachedHistoryNodes := historyBuilder historyNodes.
	
	cachedHeadHistoryNodes := historyBuilder headHistoryNode.
]

{ #category : #accessing }
FiEpiceaStore >> theLog [

	^ theLog ifNil: [ theLog := EpMonitor current log ]
]

{ #category : #accessing }
FiEpiceaStore >> theLog: anEpLog [

	^ theLog := anEpLog
]
