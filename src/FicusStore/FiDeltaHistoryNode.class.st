"
I'm a history node that knows the delta with the prior node. This means that the answer of #snapshot is computed.
"
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
	#category : #'FicusStore-Models'
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
		cachedPriors := { prior } asFiSet ]
]

{ #category : #accessing }
FiDeltaHistoryNode >> snapshot [

	^ cachedSnapshot ifNil: [ 
		cachedSnapshot := prior snapshot resultOf: edit ]
]
