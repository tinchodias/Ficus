Class {
	#name : #FiEpiceaStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'theLog',
		'packageName',
		'historyNodes',
		'headHistoryNode'
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

{ #category : #private }
FiEpiceaStore >> ensureReady [

	historyNodes ifNil: [ self refresh ].
]

{ #category : #accessing }
FiEpiceaStore >> headHistoryNode [

	self ensureReady.

	^ headHistoryNode
]

{ #category : #accessing }
FiEpiceaStore >> historyNodes [

	self ensureReady.

	^ historyNodes
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
	
	headHistoryNode := historyBuilder headHistoryNode.
]

{ #category : #accessing }
FiEpiceaStore >> theLog: anEpLog [

	theLog := anEpLog
]
