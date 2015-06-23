Class {
	#name : #EFiEpiceaRevision,
	#superclass : #EFiRevision,
	#instVars : [
		'edit',
		'cachedSnapshot',
		'cachedPrior',
		'priorName',
		'cachedChange'
	],
	#category : #'EpiceaFicus-Repositories'
}

{ #category : #accessing }
EFiEpiceaRevision >> change [

	^ cachedChange ifNil: [ 
		cachedChange := self prior snapshot changeOf: edit ]
]

{ #category : #accessing }
EFiEpiceaRevision >> deltas [

	^ { self prior -> self change }
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
