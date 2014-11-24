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
	
	self assertClosestCommonHistoryNodeFor: {a. a} equals: a.	
	self assertClosestCommonHistoryNodeFor: {a. b} equals: a.	
	self assertClosestCommonHistoryNodeFor: {b. c} equals: a.
]
