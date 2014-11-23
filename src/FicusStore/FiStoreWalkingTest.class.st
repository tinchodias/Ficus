Class {
	#name : #FiStoreWalkingTest,
	#superclass : #TestCase,
	#instVars : [
		'a',
		'b',
		'c',
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
	self assertCommonAncestorOf: {b. a} equals: a.	
	self assertCommonAncestorOf: {b. c} equals: a.
]
