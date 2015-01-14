Class {
	#name : #FiEpiceaStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'theLog',
		'packageName'
	],
	#category : #FicusEpicea
}

{ #category : #'instance creation' }
FiEpiceaStore class >> forPackageNamed: aString [ 

	^ self new
		packageName: aString;
		yourself
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

	cachedHistoryNodes := historyBuilder historyNodes.
	
	cachedHeadHistoryNodes := historyBuilder headHistoryNode.
]

{ #category : #accessing }
FiEpiceaStore >> theLog: anEpLog [

	^ theLog := anEpLog
]
