Class {
	#name : #FiPatchHistoryNode,
	#superclass : #FiHistoryNode,
	#instVars : [
		'prior',
		'edit',
		'cachedSnapshot',
		'cachedEffect',
		'cachedPriors'
	],
	#category : #'FicusStore-History-Models'
}

{ #category : #accessing }
FiPatchHistoryNode class >> excludedInstanceVariableNamesForSteps [

	^ super excludedInstanceVariableNamesForSteps, #(cachedSnapshot cachedEffect cachedPriors)
]

{ #category : #accessing }
FiPatchHistoryNode >> edit [

	^ edit
]

{ #category : #accessing }
FiPatchHistoryNode >> effect [

	^ cachedEffect ifNil: [ 
		cachedEffect := prior snapshot effectOf: edit ]
]

{ #category : #accessing }
FiPatchHistoryNode >> patches [

	^ { prior -> self effect }
]

{ #category : #accessing }
FiPatchHistoryNode >> priors [

	^ cachedPriors ifNil: [ 
		cachedPriors := FiSet withValues: { prior } ]
]

{ #category : #accessing }
FiPatchHistoryNode >> snapshot [

	^ cachedSnapshot ifNil: [ 
		cachedSnapshot := prior snapshot resultOf: edit ]
]
