Class {
	#name : #FiStoreTest,
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
FiStoreTest >> commitWithPriors: aCollection [

	store 
		commitSnapshot: FiSet new "snapshot is irrelevant"
		priors: aCollection asFiSet.

	^ store headHistoryNode
]

{ #category : #running }
FiStoreTest >> setUp [

	super setUp.
	
	store := FiMemoryStore new.
]

{ #category : #tests }
FiStoreTest >> setUpAlreadyMergedStore [
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

]

{ #category : #tests }
FiStoreTest >> setUpSimpleStore [
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

]
