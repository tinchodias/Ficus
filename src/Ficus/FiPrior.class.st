Class {
	#name : #FiPrior,
	#superclass : #FiShot,
	#instVars : [
		'historyName'
	],
	#category : #'Ficus-Model-Store'
}

{ #category : #accessing }
FiPrior >> historyName [
	
	^ historyName
]

{ #category : #accessing }
FiPrior >> historyName: anObject [
	
	historyName := anObject
]
