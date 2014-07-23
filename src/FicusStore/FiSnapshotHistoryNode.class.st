Class {
	#name : #FiSnapshotHistoryNode,
	#superclass : #FiHistoryNode,
	#instVars : [
		'snapshot',
		'priors'
	],
	#category : #'FicusStore-HistoryNodes'
}

{ #category : #accessing }
FiSnapshotHistoryNode >> patches [

	^ priors collect: [ :aPrior |
		aPrior -> (snapshot differenceFrom: aPrior) ]
]

{ #category : #accessing }
FiSnapshotHistoryNode >> priors [

	^ priors
]

{ #category : #accessing }
FiSnapshotHistoryNode >> snapshot [

	^ snapshot
]
