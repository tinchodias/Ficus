Class {
	#name : #FiPrior,
	#superclass : #FiShot,
	#instVars : [
		'historyName'
	],
	#category : #'FicusStore-Model'
}

{ #category : #accessing }
FiPrior >> historyName [
	
	^ historyName
]

{ #category : #accessing }
FiPrior >> historyName: anObject [
	
	historyName := anObject
]
