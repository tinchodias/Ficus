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
		'cachedPriors',
		'cachedChange'
	],
	#category : #'FicusStore-Models'
}

{ #category : #accessing }
FiDeltaHistoryNode class >> excludedInstanceVariableNamesForSteps [

	^ super excludedInstanceVariableNamesForSteps, #(cachedSnapshot cachedChange cachedPriors)
]

{ #category : #accessing }
FiDeltaHistoryNode >> change [

	^ cachedChange ifNil: [ 
		cachedChange := prior snapshot changeOf: edit ]
]

{ #category : #accessing }
FiDeltaHistoryNode >> deltas [

	^ { prior -> self change }
]

{ #category : #accessing }
FiDeltaHistoryNode >> edit [

	^ edit
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
