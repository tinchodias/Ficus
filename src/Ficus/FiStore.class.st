"
A FiStore is xxxxxxxxx.


Edits are commited in a store. The store tells to its histories about each new commit, which histories may want to tag with  their specific 'prior'.


"
Class {
	#name : #FiStore,
	#superclass : #Object,
	#instVars : [
		'histories',
		'shots',
		'head'
	],
	#category : #'Ficus-Store'
}

{ #category : #histories }
FiStore >> addHistory: aHistory [ 

	histories add: aHistory
]

{ #category : #operations }
FiStore >> commit: anEdit [

	| newCommit editEffect newRoot |
		
	newRoot := self head root resultOf: anEdit. 
	editEffect := self head root effectOf: anEdit. 

	newCommit := FiCommit new
		timestamp: DateAndTime now;
		editEffect: editEffect;				"#edits"
		root: newRoot; 						"1"
		priors: (self priorsOf: anEdit); 		"<= #histories"
		yourself.
	
	self newCommit: newCommit.

	head := newCommit.

"	newShot commit: newCommit."
"	newShot tagsAt: #commit put: newCommit."
"	newShot tag: newCommit. 
		(either: 
			- tags are added at last of a list
			- it's a composite structure where in most cases its only one tag)
		(in any case, multiple commits for same shot)"
"	newShot tag: newCommit / anEdit path. (like an id) "
"	newShot tag: newCommit / shot, anEdit path. (like an id) "
	
	^ newCommit
]

{ #category : #accessing }
FiStore >> commitTaggedAs: tag [ 
	
	^ shots detect: [ :shot | 
		shot tag = (FiPath root / tag steps first) ]
]

{ #category : #accessing }
FiStore >> head [

	^ head
]

{ #category : #accessing }
FiStore >> head: anObject [

	head := anObject
]

{ #category : #operations }
FiStore >> initialCommit: aRoot [

	| newCommit |
		
	newCommit := FiCommit new
		timestamp: DateAndTime now;
		editEffect: FiNoEdit new effectNothing;
		root: aRoot;
		priors: #();
		yourself.
	
	self newCommit: newCommit.

	head := newCommit.
	
	^ newCommit
]

{ #category : #initialization }
FiStore >> initialize [ 

	super initialize.
	
	histories := Set new.
	shots := OrderedCollection new.
]

{ #category : #private }
FiStore >> newCommit: aCommit [
	
	self flag: #fix. "FIX: find a good commit tag"
	
	^ aCommit 
		ficusDeepDo: [ :value :path | 
			(value isShot and: [ value hasTag not ])
				ifTrue: [ self newShot: value tag: path ] ]
		basePath: (UUID new asString first: 3) asSymbol asFicusPath
]

{ #category : #private }
FiStore >> newShot: aShot tag: aTag [
	"Simulates serialization"

	| prunedShot |
	prunedShot := aShot pruned tag: aTag.
	aShot tag: aTag.

	^ shots addLast: prunedShot
]

{ #category : #private }
FiStore >> priorsOf: anEdit [

	^ histories flatCollect: [ :history |
		history priorsOf: anEdit ]
]

{ #category : #accessing }
FiStore >> shots [

	^ shots
]
