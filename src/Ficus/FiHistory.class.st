Class {
	#name : #FiHistory,
	#superclass : #Object,
	#instVars : [
		'historyName',
		'watchedPath',
		'store'
	],
	#category : #'Ficus-Store'
}

{ #category : #accessing }
FiHistory >> headAt: step [ 
	
	| shot |
	shot := (self watchedPath / step) resolvedOn: self store head root.
	
	^ self store commitTaggedAs: shot tag
]

{ #category : #accessing }
FiHistory >> historyName [

	^ historyName
]

{ #category : #accessing }
FiHistory >> historyName: anObject [

	historyName := anObject
]

{ #category : #accessing }
FiHistory >> priorTo: aCommit [ 

	^ aCommit priors detect: [ :prior | prior historyName = self historyName ]
]

{ #category : #accessing }
FiHistory >> priorsOf: anEdit [ 
	
	^ (anEdit affects: self watchedPath)
		ifTrue: [ { FiPrior new historyName: self historyName; tag: #?; yourself } ]
		ifFalse: [ #() ]
]

{ #category : #accessing }
FiHistory >> store [

	^ store
]

{ #category : #accessing }
FiHistory >> store: anObject [

	store := anObject
]

{ #category : #accessing }
FiHistory >> watchedPath [

	^ watchedPath
]

{ #category : #accessing }
FiHistory >> watchedPath: anObject [

	watchedPath := anObject
]
