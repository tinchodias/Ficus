Class {
	#name : #RFiAbstractAnalysedMethod,
	#superclass : #FiFixedObject,
	#instVars : [
		'selector',
		'hostName',
		'isMeta',
		'sourceCode'
	],
	#category : #'FicusImpact-Old-Analyzer'
}

{ #category : #accessing }
RFiAbstractAnalysedMethod >> defaultStep [
	
	^ ((isMeta 
		ifFalse: [ hostName ]
		ifTrue: [ hostName,  ' class' ]), '>>', selector) asSymbol 
]

{ #category : #accessing }
RFiAbstractAnalysedMethod >> hostName [
	
	^ hostName
]

{ #category : #accessing }
RFiAbstractAnalysedMethod >> isMeta [
	
	^ isMeta
]

{ #category : #accessing }
RFiAbstractAnalysedMethod >> selector [
	
	^ selector
]

{ #category : #accessing }
RFiAbstractAnalysedMethod >> sourceCode [
	
	^ sourceCode
]
