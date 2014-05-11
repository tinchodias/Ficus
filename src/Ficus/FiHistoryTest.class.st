"
A FiStoreTest is a test class for testing the behavior of FiStore
"
Class {
	#name : #FiHistoryTest,
	#superclass : #TestCase,
	#instVars : [
		'store'
	],
	#category : #'Ficus-Tests'
}

{ #category : #tests }
FiHistoryTest >> testCommitClass [

	| commit shot edit aHistory |
	store := FiStore new initialCommit: FiDictionary new; yourself.
	shot := FiClass named: #A.
	edit := store head root at: #A equal: shot.
	
	aHistory := 
		FiHistory new 
			historyName: #system;
			watchedPath: FiPath root; 
			store: store;
			yourself.
	store addHistory: aHistory.
	
	commit := store commit: edit.
	
	self assert: ((aHistory headAt: #A) proxyEquals: commit).
	
]
