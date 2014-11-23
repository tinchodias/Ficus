Class {
	#name : #FiMemoryStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'historyNodes'
	],
	#category : #'FicusStore-Stores'
}

{ #category : #'as yet unclassified' }
FiMemoryStore >> commitSnapshot: aSnapshot priors: priors [
	
	self invalidateCaches.
	
	historyNodes add: 
		(FiSnapshotHistoryNode builder
			origin: (FiSingleOrigin builder reference: ('Mem:', self hash asString, ':', historyNodes size asString); new);
			snapshot: aSnapshot;
			priors: priors;
			new)
]

{ #category : #'as yet unclassified' }
FiMemoryStore >> commonAncestorOf: aCollection [ 
	"Answer the closest common ancestor of all the received FiHistoryNodes."
	
	| allPriors commonPriors |
	self assert: aCollection size >= 2.
	
	allPriors := aCollection collect: [ :each | {each}, (self priorsOf: each) ].
	
	commonPriors := allPriors fold: [ :each :another | each intersection: another ].
	
	^ commonPriors first "the closest one is at the beginning"
]

{ #category : #refreshing }
FiMemoryStore >> initialize [

	super initialize.
	
	historyNodes := OrderedCollection new.
]

{ #category : #printing }
FiMemoryStore >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: self hash;
		nextPut: $).
]

{ #category : #'as yet unclassified' }
FiMemoryStore >> priorsOf: aValue [ 
	
	| result pendingPriors |
	result := OrderedCollection new.
	pendingPriors := Stack withAll: aValue priors asArray.
	
	[ pendingPriors isEmpty ] whileFalse: [ 
		| current |
		current := pendingPriors pop.
		result add: current.
		
		pendingPriors addAll: current priors asArray.		
	].

	^ result
]

{ #category : #refreshing }
FiMemoryStore >> refresh [

	cachedHistoryNodes := historyNodes.
	cachedHeadHistoryNodes := historyNodes last.
]
