Class {
	#name : #FiMemoryStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'historyNodes'
	],
	#category : #'FicusStore-Stores'
}

{ #category : #example }
FiMemoryStore class >> example [
	"
	self example inspect
	"

	^ self exampleWithAll: ((1 to: 10) collect: [ :index | 'Item ', index asString ])
]

{ #category : #example }
FiMemoryStore class >> exampleWithAll: items [

	| store |
	store := FiMemoryStore new.
	store commitSnapshot: FiSet new priors: FiSet new.

	1 to: items size do: [ :index |
		store 
			commitSnapshot: (items first: index) asFiSet 
			priors: { store headHistoryNode } asFiSet ].

	^ store
]

{ #category : #accessing }
FiMemoryStore >> allPriorsOf: aValue [ 
	
	| result pendingPriors |
	result := OrderedCollection new.
	pendingPriors := Stack withAll: aValue priors asArray.
	
	[ pendingPriors isEmpty ] whileFalse: [ 
		| current |
		current := pendingPriors pop.
		
		(result includes: current) ifFalse: [
			result add: current.
		
			pendingPriors addAll: current priors asArray ]
	].

	^ result asArray
]

{ #category : #accessing }
FiMemoryStore >> closestCommonHistoryNodeFor: aCollection [ 
	"Answer the closest common ancestor of all the received FiHistoryNodes."
	
	| ancestries commonPriors |
	self assert: aCollection size >= 2.
	
	ancestries := aCollection collect: [ :each | {each}, (self allPriorsOf: each) ].
	
	commonPriors := ancestries fold: [ :commons :anAncestry | 
		commons select: [ :each | anAncestry includes: each ] ].
	
	^ commonPriors first "the closest one is at the beginning"
]

{ #category : #accessing }
FiMemoryStore >> commitSnapshot: aSnapshot priors: priors [
	
	historyNodes add: 
		(FiSnapshotHistoryNode builder
			origin: (FiSingleOrigin builder reference: ('Mem:', self hash asString, ':', historyNodes size asString); new);
			snapshot: aSnapshot;
			priors: priors;
			new)
]

{ #category : #accessing }
FiMemoryStore >> headHistoryNode [

	^ historyNodes last
]

{ #category : #accessing }
FiMemoryStore >> historyNodes [

	^ historyNodes
]

{ #category : #initialization }
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

{ #category : #refreshing }
FiMemoryStore >> refresh [

	"nothing to do"
]
