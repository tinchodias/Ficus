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

	| historyBuilder  |
	historyBuilder := 
		FiEpiceaHistoryBuilder new 
			packageName: packageName;
			theLog: self theLog;
			yourself. 
	cachedHistoryNodes := historyBuilder historyNodes.
	
"	headReference := self theLog headReference."
	cachedHeadHistoryNodes := 
		cachedHistoryNodes last"
			detect: [ :node | node origin anySatisfy: [ :origin | origin reference = headReference ] ]
			ifNone: [ self notYetImplemented ]
"
]

{ #category : #accessing }
FiEpiceaStore >> theLog [

	^ theLog ifNil: [ theLog := EpMonitor current log ]
]

{ #category : #accessing }
FiEpiceaStore >> theLog: anEpLog [

	^ theLog := anEpLog
]
