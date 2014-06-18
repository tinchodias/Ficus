Class {
	#name : #FiAnalysedMethod,
	#superclass : #FiAbstractAnalysedMethod,
	#instVars : [
		'dependencies'
	],
	#category : #FicusImpact
}

{ #category : #'instance creation' }
FiAnalysedMethod class >> selector: aSelector sourceCode: aSourceCode dependencies: aSet [
	
	^ self new
		selector: aSelector;
		sourceCode: aSourceCode;
		dependencies: aSet;
		yourself

]

{ #category : #accessing }
FiAnalysedMethod >> dependencies [
	
	^ dependencies
]

{ #category : #accessing }
FiAnalysedMethod >> dependencies: aSet [ 

	dependencies := aSet
]
