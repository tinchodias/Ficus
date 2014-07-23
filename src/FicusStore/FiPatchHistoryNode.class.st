Class {
	#name : #FiPatchHistoryNode,
	#superclass : #FiHistoryNode,
	#instVars : [
		'patch',
		'prior'
	],
	#category : #'FicusStore-HistoryNodes'
}

{ #category : #accessing }
FiPatchHistoryNode >> patches [

	^ { prior -> patch }
]

{ #category : #accessing }
FiPatchHistoryNode >> priors [

	^ { prior }
]

{ #category : #accessing }
FiPatchHistoryNode >> snapshot [

	^ prior snapshot resultOf: patch
]
