Class {
	#name : #FiMemoryStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'historyNodes'
	],
	#category : #'FicusStore-History-Models'
}

{ #category : #'as yet unclassified' }
FiMemoryStore >> commitSnapshot: aSnapshot priors: priors [
	
	self invalidateCaches.
	
	historyNodes add: 
		(FiSnapshotHistoryNode builder
			origin: (FiSingleCommit builder reference: ('Mem:', self hash asString, ':', historyNodes size asString); new);
			snapshot: aSnapshot;
			priors: priors;
			new)
]

{ #category : #refreshing }
FiMemoryStore >> initialize [

	super initialize.
	
	historyNodes := OrderedCollection new.
]

{ #category : #refreshing }
FiMemoryStore >> refresh [

	cachedHistoryNodes := historyNodes.
	cachedHeadHistoryNodes := historyNodes last.
]
