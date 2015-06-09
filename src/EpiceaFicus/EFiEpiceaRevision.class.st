Class {
	#name : #EFiEpiceaRevision,
	#superclass : #EFiRevision,
	#instVars : [
		'edit',
		'cachedEffect',
		'cachedSnapshot',
		'cachedPrior',
		'priorName'
	],
	#category : #'EpiceaFicus-Repositories'
}

{ #category : #accessing }
EFiEpiceaRevision >> deltas [

	^ { self prior -> self effect }
]

{ #category : #accessing }
EFiEpiceaRevision >> edit [

	^ edit
]

{ #category : #accessing }
EFiEpiceaRevision >> edit: anObject [
	edit := anObject
]

{ #category : #accessing }
EFiEpiceaRevision >> effect [

	^ cachedEffect ifNil: [ 
		cachedEffect := self prior snapshot effectOf: edit ]
]

{ #category : #accessing }
EFiEpiceaRevision >> prior [

	^ cachedPrior ifNil: [
		cachedPrior := repository revisionAt: priorName ]
]

{ #category : #accessing }
EFiEpiceaRevision >> priorName [
	^ priorName
]

{ #category : #accessing }
EFiEpiceaRevision >> priorName: anObject [
	priorName := anObject
]

{ #category : #accessing }
EFiEpiceaRevision >> priors [

	^ { self prior }
]

{ #category : #accessing }
EFiEpiceaRevision >> snapshot [

	^ cachedSnapshot ifNil: [ 
		cachedSnapshot := self prior snapshot resultOf: edit ]
]
