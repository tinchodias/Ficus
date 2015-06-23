"
I'm a history node that knows the #snapshot. This means that the answer of #deltas is computed.
"
Class {
	#name : #FiSnapshotHistoryNode,
	#superclass : #FiHistoryNode,
	#instVars : [
		'snapshot',
		'priors'
	],
	#category : #'FicusStore-Models'
}

{ #category : #comparing }
FiSnapshotHistoryNode >> = other [

	self flag: #fix. "Just a hack for playing"

	^ self class == other class
		and: [ self origin = other origin
		and: [ self snapshot hash = other snapshot hash 
		and: [ self priors hash = other priors hash ] ] ]
]

{ #category : #accessing }
FiSnapshotHistoryNode >> deltas [

	^ priors asArray collect: [ :aPrior |
		aPrior -> (snapshot changeFrom: aPrior snapshot) ]
]

{ #category : #comparing }
FiSnapshotHistoryNode >> hash [

	self flag: #fix. "Just a hack for playing"

	^ ((self class hash
		bitXor: self origin hash)
		bitXor: self snapshot hash)
		bitXor: self priors hash
]

{ #category : #accessing }
FiSnapshotHistoryNode >> priors [

	^ priors
]

{ #category : #accessing }
FiSnapshotHistoryNode >> snapshot [

	^ snapshot
]
