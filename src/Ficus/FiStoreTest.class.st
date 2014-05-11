"
A FiStoreTest is a test class for testing the behavior of FiStore
"
Class {
	#name : #FiStoreTest,
	#superclass : #TestCase,
	#instVars : [
		'store'
	],
	#category : #'Ficus-Tests'
}

{ #category : #tests }
FiStoreTest >> testCommitClass [

	" TODO:
	- plain IDE events?
	"

	| commit shot edit |
	store := FiStore new initialCommit: FiDictionary new; yourself.

	shot := FiClass named: #A.

	edit := store head root at: #A equal: shot.
	
	commit := store commit: edit.

	self assert: store shots size equals: store shots asSet size. "no repetition of objects (modulo =)"

	self assert: (store shots count: [ :e | e proxyEquals: shot ]) equals: 1.
	self assert: (store shots count: [ :e | e proxyEquals: edit ]) equals: 1.
	self assert: (store shots count: [ :e | e proxyEquals: commit ]) equals: 1.

	"assert that a shot with tag x does not reference shots with tag >= x (it's a tree)"
	
	self assert: (store shots allSatisfy: #hasTag). "should be have a tag"
	"self assert: (store shots allSatisfy: #isRoot).?" "shots that aren't roots should be embedded"
	self assert: (store shots allSatisfy: #isPruned)."should be pointing to no-shots or no-roots (or proxies)"
	self assert: (store shots noneSatisfy: #isProxy). "should be embedded -> redundant (root)"
]

{ #category : #tests }
FiStoreTest >> testTwoCommits [

	| commitA commitB |
	store := 
		FiStore new 
			initialCommit: FiDictionary new; 
			yourself.

	commitA := 
		store commit: 
			(store head root 
				at: #A 
				equal: (FiClass named: #A)).

	commitB := 
		store commit: 
			(store head root 
				at: #B 
				equal: (FiClass named: #B)).
	
	self assert: (store shots count: [ :e | e isKindOf: FiDictionary ]) equals: 3
]
