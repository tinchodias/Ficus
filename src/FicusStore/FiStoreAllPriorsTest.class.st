Class {
	#name : #FiStoreAllPriorsTest,
	#superclass : #FiStoreTest,
	#category : #'FicusStore-Stores'
}

{ #category : #tests }
FiStoreAllPriorsTest >> testAlreadyMerged [
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
]

{ #category : #tests }
FiStoreAllPriorsTest >> testSimple [
	"
	c
	|
	| b
	|/
	a
	"
	self setUpSimpleStore.

	self assert: (store allPriorsOf: a) equals: {}.
	self assert: (store allPriorsOf: b) equals: {a}.
	self assert: (store allPriorsOf: c) equals: {a}.
]
