"
I am a store that lives in memory, i.e. has no explicit external persistence.
"
Class {
	#name : #FiMemoryStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'historyNodes',
		'name'
	],
	#category : #'FicusStore-Stores'
}

{ #category : #example }
FiMemoryStore class >> exampleFragileBaseProblem [
	"
	self exampleFragileBaseProblem inspect
	"

	^ self exampleFragileBaseProblem: [ :each | each new ficusEnvironment ]
]

{ #category : #example }
FiMemoryStore class >> exampleFragileBaseProblem: factoryBlock [

	| store snapshots commonPrior |
	snapshots := { 
		FiFragileBaseClassProblemResources0.
		FiFragileBaseClassProblemResources1.
		FiFragileBaseClassProblemResources2.
		FiFragileBaseClassProblemResources3.
	} collect: [ :each | factoryBlock value: each ].

	store := FiMemoryStore new.
	store name: 'FragileBaseClassProblem'.

	"first commit"
	store 
		commitSnapshot: snapshots first
		priors: FiSet new.

	"more commits"
	2 to: snapshots size do: [ :index |
		store 
			commitSnapshot: (snapshots at: index)
			priors: { store headHistoryNode } asFiSet ].
			
	commonPrior := store headHistoryNode.

	"fork A"
	store 
		commitSnapshot: (factoryBlock value: FiFragileBaseClassProblemResources4A)
		priors: { commonPrior } asFiSet.
	store 
		commitSnapshot: (factoryBlock value: FiFragileBaseClassProblemResources5A)
		priors: { store headHistoryNode } asFiSet.

	"fork B"
	store 
		commitSnapshot: (factoryBlock value: FiFragileBaseClassProblemResources4B)
		priors: { commonPrior } asFiSet.

	^ store
]

{ #category : #example }
FiMemoryStore class >> exampleFragileBaseProblemOnlyPackage [
	"
	self exampleFragileBaseProblemOnlyPackage inspect
	"

	^ self exampleFragileBaseProblem: [ :each | each new packageLoggers ]
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
	
	^ historyNodes add: 
		(FiSnapshotHistoryNode builder
			origin: (FiSingleOrigin withReference: (self name, '.', historyNodes size asString));
			snapshot: aSnapshot;
			priors: priors;
			new)
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

{ #category : #accessing }
FiMemoryStore >> name [

	^ name ifNil: [ name := self hash printStringHex ]
]

{ #category : #accessing }
FiMemoryStore >> name: aString [

	name := aString
]

{ #category : #printing }
FiMemoryStore >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: self name;
		nextPut: $).
]

{ #category : #refreshing }
FiMemoryStore >> refresh [

	"nothing to do"
]
