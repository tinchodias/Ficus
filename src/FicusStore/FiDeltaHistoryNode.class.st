Class {
	#name : #FiDeltaHistoryNode,
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
FiDeltaHistoryNode class >> excludedInstanceVariableNamesForSteps [

	^ super excludedInstanceVariableNamesForSteps, #(cachedSnapshot cachedEffect cachedPriors)
]

{ #category : #accessing }
FiDeltaHistoryNode >> deltas [

	^ { prior -> self effect }
]

{ #category : #accessing }
FiDeltaHistoryNode >> edit [

	^ edit
]

{ #category : #accessing }
FiDeltaHistoryNode >> effect [

	^ cachedEffect ifNil: [ 
		cachedEffect := prior snapshot effectOf: edit ]
]

{ #category : #accessing }
FiDeltaHistoryNode >> priors [

	^ cachedPriors ifNil: [ 
		cachedPriors := FiSet withValues: { prior } ]
]

{ #category : #accessing }
FiDeltaHistoryNode >> snapshot [

	^ cachedSnapshot ifNil: [ 
		cachedSnapshot := prior snapshot resultOf: edit ]
]
