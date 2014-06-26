Class {
	#name : #FiAbstractAnalysedMethod,
	#superclass : #FiFixedObject,
	#instVars : [
		'selector',
		'hostName',
		'isMeta',
		'sourceCode'
	],
	#category : #'FicusImpact-Prototype'
}

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
FiAbstractAnalysedMethod >> isMeta [
	
	^ isMeta
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> selector [
	
	^ selector
]

{ #category : #accessing }
FiAbstractAnalysedMethod >> sourceCode [
	
	^ sourceCode
]
