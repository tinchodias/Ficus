Class {
	#name : #FiAnalysedMethod,
	#superclass : #FiAbstractAnalysedMethod,
	#instVars : [
		'dependencies',
		'impact'
	],
	#category : #'FicusImpact-Analyzer'
}

{ #category : #accessing }
FiAnalysedMethod >> dependencies [
	
	^ dependencies
]

{ #category : #accessing }
FiAnalysedMethod >> impact [
	
	^ impact
]
