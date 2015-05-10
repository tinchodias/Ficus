"
I represent an abstract point in the history.
"
Class {
	#name : #FiHistoryNode,
	#superclass : #FiFixedObject,
	#instVars : [
		'origin'
	],
	#category : #'FicusStore-Models'
}

{ #category : #accessing }
FiHistoryNode >> defaultStep [

	^ origin printString asSymbol
]

{ #category : #accessing }
FiHistoryNode >> deltas [

	^ self shouldBeImplemented 
]

{ #category : #printing }
FiHistoryNode >> ficusInspectorDefinitionString [

	^ self printString
]

{ #category : #printing }
FiHistoryNode >> gtInspectorDeltasIn: composite [
	<gtInspectorPresentationOrder: 26> 

	composite morph
		title: [ 'Deltas' ];
		display: [:shot | 
			(FiDeltasInspector new 
				plugin: FiNullStoreBrowserPlugin new;
				deltas: self deltas;
				buildWithSpec;
				yourself) widget widget ]
]

{ #category : #printing }
FiHistoryNode >> gtInspectorSnapshotIn: composite [
	<gtInspectorPresentationOrder: 25> 

	composite morph
		title: [ 'Snapshot' ];
		display: [:shot | 
			(FiInspector new 
"				plugin: FiNullStoreBrowserPlugin new;"
				rootShot: self snapshot;
				buildWithSpec;
				yourself) widget widget ]
]

{ #category : #testing }
FiHistoryNode >> isWorkingCopy [

	^ false
]

{ #category : #querying }
FiHistoryNode >> mostRecentHistoryNodeChanging: aPath [ 
	
	(self deltas anySatisfy: [ :delta | 
		delta value asSimpleEffects asArray anySatisfy: [ :simpleEffect |
			simpleEffect hasEffectAt: aPath ] ])
			ifTrue: [ ^ self ].

	^ self mostRecentPriorHistoryNodeChanging: aPath
]

{ #category : #querying }
FiHistoryNode >> mostRecentPriorHistoryNodeChanging: aPath [ 
	
	self flag: #todo. "rewrite"
	
	self priors asArray 
		ifNotEmpty: [ :priorHistoryNodes |
			"Defect? if more than one prior, we just return the first one."
			priorHistoryNodes do: [ :priorHistoryNode |
				(priorHistoryNode mostRecentHistoryNodeChanging: aPath)
					ifNotNil: [ :result | ^ result ] ] ]
		ifEmpty: [ 
			"Workaround? because the first node has no delta, i.e., no addition effects"
			(aPath canBeResolvedOn: self snapshot) ifTrue: [ ^ self ] ].
	
	^ nil
]

{ #category : #accessing }
FiHistoryNode >> origin [

	^ origin
]

{ #category : #printing }
FiHistoryNode >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self origin printString;
		nextPut: $).
	
]

{ #category : #accessing }
FiHistoryNode >> priors [

	^ self shouldBeImplemented 
]

{ #category : #accessing }
FiHistoryNode >> snapshot [

	^ self shouldBeImplemented 
]
