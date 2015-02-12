Class {
	#name : #FiOmbuStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'historyNodes',
		'underlyingStore',
		'forkedStore'
	],
	#category : #FicusEpicea
}

{ #category : #example }
FiOmbuStore class >> example [

	^ self newOn: (OmFileStore named: 'example')
]

{ #category : #'instance creation' }
FiOmbuStore class >> newOn: anOmStore [

	^ self new 
		underlyingStore: anOmStore;
		yourself

]

{ #category : #accessing }
FiOmbuStore >> commitSnapshot: aSnapshot priors: priors [

	| newEntry delta thePrior |
	priors size = 1 ifFalse: [ self notYetImplemented ].
	thePrior := priors anyOne.
	delta := aSnapshot differenceFrom: thePrior snapshot.
	
	newEntry := OmEntry content: delta.

	"add tags"
	newEntry tags 
		at: #prior put: thePrior origin reference.

	"write the new entry"
	underlyingStore newEntry: newEntry.

	self refresh.
	^ self headHistoryNode.

]

{ #category : #accessing }
FiOmbuStore >> forkedStore: aFiStore [
	
	forkedStore := aFiStore
]

{ #category : #private }
FiOmbuStore >> historyNodeFor: anOmEntry [

	| priorReference priorHistoryNode |
	priorReference := anOmEntry tagAt: #prior.

	priorHistoryNode := 
		priorReference isString
			ifTrue: [ 
				historyNodes addAll: forkedStore historyNodes.
				forkedStore historyNodes detect: [ :each | each origin reference = priorReference ]  ]
			ifFalse: [
				| priorEntry |
				priorEntry := underlyingStore entryFor: priorReference.
				
				self historyNodeFor: priorEntry. ].

	^ historyNodes add: (
		self 
			historyNodeFor: anOmEntry 
			prior: priorHistoryNode).

]

{ #category : #private }
FiOmbuStore >> historyNodeFor: anOmEntry prior: priorHistoryNode [
	
	| origin |
	origin := FiSingleOrigin withReference: (anOmEntry tagAt: #self).

	^ FiDeltaHistoryNode builder
		origin: origin;
		edit: anOmEntry content edit;
		prior: priorHistoryNode;
		new
]

{ #category : #accessing }
FiOmbuStore >> historyNodes [

	self ensureReady.

	^ historyNodes
]

{ #category : #testing }
FiOmbuStore >> isReady [

	^ historyNodes isNotNil
]

{ #category : #refreshing }
FiOmbuStore >> refresh [

	historyNodes := OrderedCollection new.
	
	self historyNodeFor: underlyingStore entries last.

]

{ #category : #accessing }
FiOmbuStore >> underlyingStore [ 

	^ underlyingStore

]

{ #category : #accessing }
FiOmbuStore >> underlyingStore: anOmStore [ 

	underlyingStore := anOmStore 
]
