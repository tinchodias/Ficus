Class {
	#name : #FiEpiceaStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'theLog',
		'packageName',
		'historyNodes'
	],
	#category : #FicusEpicea
}

{ #category : #'instance creation' }
FiEpiceaStore class >> forPackageNamed: aString [ 

	^ self new
		packageName: aString;
		theLog: EpMonitor current log;
		yourself
]

{ #category : #accessing }
FiEpiceaStore >> historyNodes [

	self ensureReady.

	^ historyNodes
]

{ #category : #testing }
FiEpiceaStore >> isReady [

	^ historyNodes isNil
]

{ #category : #accessing }
FiEpiceaStore >> packageName: anObject [

	packageName := anObject 
]

{ #category : #refreshing }
FiEpiceaStore >> refresh [

	| historyBuilder |
	historyBuilder := 
		FiEpiceaHistoryBuilder new 
			packageName: packageName;
			theLog: theLog;
			run;
			yourself. 

	historyNodes := historyBuilder historyNodes.

]

{ #category : #accessing }
FiEpiceaStore >> theLog: anEpLog [

	theLog := anEpLog
]
