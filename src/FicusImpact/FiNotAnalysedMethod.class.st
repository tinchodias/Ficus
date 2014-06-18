Class {
	#name : #FiNotAnalysedMethod,
	#superclass : #FiAbstractAnalysedMethod,
	#category : #FicusImpact
}

{ #category : #'instance creation' }
FiNotAnalysedMethod class >> selector: aSelector sourceCode: aSourceCode [

	^ self new
		selector: aSelector;
		sourceCode: aSourceCode;
		yourself

]
