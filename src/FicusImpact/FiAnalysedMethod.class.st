Class {
	#name : #FiAnalysedMethod,
	#superclass : #FiAbstractAnalysedMethod,
	#instVars : [
		'dependencies',
		'impact'
	],
	#category : #'FicusImpact-Prototype'
}

{ #category : #accessing }
FiAnalysedMethod >> dependencies [
	
	^ dependencies
]

{ #category : #accessing }
FiAnalysedMethod >> dependencies: aSet [ 

	dependencies := aSet
]

{ #category : #accessing }
FiAnalysedMethod >> impact [
	
	^ impact
]

{ #category : #accessing }
FiAnalysedMethod >> impact: anObject [
	
	impact := anObject
]
