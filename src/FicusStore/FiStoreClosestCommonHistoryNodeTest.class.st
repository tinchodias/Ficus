Class {
	#name : #FiStoreClosestCommonHistoryNodeTest,
	#superclass : #FiStoreTest,
	#category : #'FicusStore-Stores'
}

{ #category : #convenience }
FiStoreClosestCommonHistoryNodeTest >> assertClosestCommonHistoryNodeFor: aCollection equals: expectedValue [
	
	| commonAncestor |
	commonAncestor := store closestCommonHistoryNodeFor: aCollection.
	
	self assert: commonAncestor equals: expectedValue.
]

{ #category : #tests }
FiStoreClosestCommonHistoryNodeTest >> testAlreadyMerged [
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
	self setUpAlreadyMergedStore.
	
	self flag: #todo. "Priors could have a random order here; these are too strong assertions."
	self assert: (store allPriorsOf: e) equals: {c. a. b}.
	self assert: (store allPriorsOf: d) equals: {c. a. b}.
	self assert: (store allPriorsOf: c) equals: {a. b}.

	self assertClosestCommonHistoryNodeFor: {e. d} equals: c.	
	self assertClosestCommonHistoryNodeFor: {e. b} equals: a.	
	self assertClosestCommonHistoryNodeFor: {e. d} equals: c.	
	self assertClosestCommonHistoryNodeFor: {e. a} equals: a.	

]

{ #category : #tests }
FiStoreClosestCommonHistoryNodeTest >> testSimple [
	"
	c
	|
	| b
	|/
	a
	"
	self setUpSimpleStore.
	
	a := self commitWithPriors: {}.
	b := self commitWithPriors: {a}.
	c := self commitWithPriors: {a}.

	self assert: (store allPriorsOf: a) equals: {}.
	self assert: (store allPriorsOf: b) equals: {a}.
	self assert: (store allPriorsOf: c) equals: {a}.
	
	self assertClosestCommonHistoryNodeFor: {a. a} equals: a.	
	self assertClosestCommonHistoryNodeFor: {a. b} equals: a.	
	self assertClosestCommonHistoryNodeFor: {b. c} equals: a.
]
