Class {
	#name : #FiStoreWalkingTest,
	#superclass : #TestCase,
	#instVars : [
		'a',
		'b',
		'c',
		'd',
		'e',
		'store'
	],
	#category : #'FicusStore-Stores'
}

{ #category : #convenience }
FiStoreWalkingTest >> assertClosestCommonHistoryNodeFor: aCollection equals: expectedValue [
	
	| commonAncestor |
	commonAncestor := store closestCommonHistoryNodeFor: aCollection.
	
	self assert: commonAncestor equals: expectedValue
]

{ #category : #convenience }
FiStoreWalkingTest >> commitWithPriors: aCollection [

	store 
		commitSnapshot: FiSet new "snapshot is irrelevant"
		priors: aCollection asFiSet.

	^ store headHistoryNode
]

{ #category : #running }
FiStoreWalkingTest >> setUp [

	super setUp.
	
	store := FiMemoryStore new.
]

{ #category : #tests }
FiStoreWalkingTest >> testAlreadyMerged [
	"
	e
	|
	| d
	|/
	c
	|\
	| b
	|/
	a
	"
	
	a := self commitWithPriors: {}.
	b := self commitWithPriors: {a}.
	c := self commitWithPriors: {a. b}.
	d := self commitWithPriors: {c}.
	e := self commitWithPriors: {c}.

	self flag: #todo. "Priors could have a random order here; these are too strong assertions."
	self assert: (store allPriorsOf: e) asArray equals: {c. a. b}.
	self assert: (store allPriorsOf: d) asArray equals: {c. a. b}.
	self assert: (store allPriorsOf: c) asArray equals: {a. b}.

	self assertClosestCommonHistoryNodeFor: {e. d} equals: c.	
	self assertClosestCommonHistoryNodeFor: {e. b} equals: a.	
	self assertClosestCommonHistoryNodeFor: {e. d} equals: c.	
	self assertClosestCommonHistoryNodeFor: {e. a} equals: a.	

]

{ #category : #tests }
FiStoreWalkingTest >> testSimple [
	"
	c
	|
	| b
	|/
	a
	"
	
	a := self commitWithPriors: {}.
	b := self commitWithPriors: {a}.
	c := self commitWithPriors: {a}.

	self assert: (store allPriorsOf: a) asArray equals: {}.
	self assert: (store allPriorsOf: b) asArray equals: {a}.
	self assert: (store allPriorsOf: c) asArray equals: {a}.
	
	self assertClosestCommonHistoryNodeFor: {a. a} equals: a.	
	self assertClosestCommonHistoryNodeFor: {a. b} equals: a.	
	self assertClosestCommonHistoryNodeFor: {b. c} equals: a.
]
