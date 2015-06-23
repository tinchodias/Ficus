Class {
	#name : #EFiGitRevision,
	#superclass : #EFiRevision,
	#instVars : [
		'snapshot',
		'priorNames'
	],
	#category : #'EpiceaFicus-Repositories'
}

{ #category : #accessing }
EFiGitRevision >> deltas [

	^ self priors collect: [ :aPrior |
		aPrior -> (snapshot changeFrom: aPrior snapshot) ]
]

{ #category : #accessing }
EFiGitRevision >> priors [

	^ priorNames collect: [ :priorName | repository revisionAt: priorName ]
]

{ #category : #accessing }
EFiGitRevision >> snapshotAt: aSpot [

	^ repository snapshotAtSpot: aSpot commitName: name
]
