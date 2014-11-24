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
FiStoreWalkingTest >> assertCommonAncestorOf: aCollection equals: expectedValue [
	
	| commonAncestor |
	commonAncestor := store commonAncestorOf: aCollection.
	
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

	self assertCommonAncestorOf: {e. d} equals: c.	
	self assertCommonAncestorOf: {e. b} equals: a.	
	self assertCommonAncestorOf: {e. d} equals: c.	
	self assertCommonAncestorOf: {e. a} equals: a.	

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

	self assertCommonAncestorOf: {a. a} equals: a.	
	self assertCommonAncestorOf: {a. b} equals: a.	
	self assertCommonAncestorOf: {b. c} equals: a.
]
