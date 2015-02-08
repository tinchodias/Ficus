"
I represent a history node that corresponds to a working copy.
"
Class {
	#name : #FiWorkingCopyHistoryNode,
	#superclass : #Object,
	#instVars : [
		'workingCopy'
	],
	#category : #'FicusStore-WorkingCopies'
}

{ #category : #accessing }
FiWorkingCopyHistoryNode >> deltas [

	^ workingCopy priors asArray collect: [ :aPrior |
		aPrior -> (workingCopy snapshot differenceFrom: aPrior snapshot) ]
]

{ #category : #testing }
FiWorkingCopyHistoryNode >> isWorkingCopy [

	^ true
]

{ #category : #accessing }
FiWorkingCopyHistoryNode >> priors [

	^ workingCopy priors
]

{ #category : #accessing }
FiWorkingCopyHistoryNode >> snapshot [

	^ workingCopy snapshot
]

{ #category : #accessing }
FiWorkingCopyHistoryNode >> workingCopy [

	^ workingCopy
]

{ #category : #'as yet unclassified' }
FiWorkingCopyHistoryNode >> workingCopy: aFiWorkingCopy [ 

	workingCopy := aFiWorkingCopy
]
