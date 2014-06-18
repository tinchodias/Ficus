Class {
	#name : #FiAbstractAnalysedMethod,
	#superclass : #FiFixedObject,
	#instVars : [
		'selector',
		'hostName',
		'isMeta',
		'sourceCode'
	],
	#category : #FicusImpact
}

{ #category : #'instance creation' }
FiAbstractAnalysedMethod class >> selector: aSelector sourceCode: aSourceCode dependencies: aSet [
	
	^ self new
		selector: aSelector;
		sourceCode: aSourceCode;
		dependencies: aSet;
		yourself

]

{ #category : #accessing }
FiAbstractAnalysedMethod >> defaultStep [
	
	^ ((isMeta 
		ifFalse: [ hostName ]
		ifTrue: [ hostName,  ' class' ]), '>>', selector) asSymbol 
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> hostName [
	
	^ hostName
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> hostName: anObject [
	
	hostName := anObject
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> isMeta [
	
	^ isMeta
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> isMeta: anObject [
	
	isMeta := anObject
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> selector [
	
	^ selector
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> selector: aSelector [

	selector := aSelector
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> sourceCode [
	
	^ sourceCode
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> sourceCode: aString [ 
	
	sourceCode := aString
]
