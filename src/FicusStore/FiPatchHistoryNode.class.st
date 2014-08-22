Class {
	#name : #FiPatchHistoryNode,
	#superclass : #FiHistoryNode,
	#instVars : [
		'prior',
		'effect'
	],
	#category : #'FicusStore-HistoryNodes'
}

{ #category : #accessing }
FiPatchHistoryNode >> patches [

	^ { prior -> effect }
]

{ #category : #accessing }
FiPatchHistoryNode >> priors [

	^ { prior }
]

{ #category : #accessing }
FiPatchHistoryNode >> snapshot [

	^ prior snapshot resultOf: effect edit
]
