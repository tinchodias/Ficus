"
I represent a method.
"
Class {
	#name : #FiMethod,
	#superclass : #FiFixedObject,
	#instVars : [
		'protocol',
		'sourceCode',
		'selector'
	],
	#category : #FicusMetamodel
}

{ #category : #accessing }
FiMethod class >> excludedInstanceVariableNamesForSteps [

	^ super excludedInstanceVariableNamesForSteps copyWith: #selector
]

{ #category : #'instance creation' }
FiMethod class >> sourceCode: aSourceCode [
	
	^ self
		sourceCode: aSourceCode
		protocol: #'as yet unclassified'
]

{ #category : #'instance creation' }
FiMethod class >> sourceCode: aSourceCode protocol: aProtocol [
	
	^ self builder
		sourceCode: aSourceCode;
		protocol: aProtocol;
		new
]

{ #category : #accessing }
FiMethod >> defaultStep [

	^ self selector asSymbol
]

{ #category : #printing }
FiMethod >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	self selector printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiMethod >> protocol [
	
	^ protocol
]

{ #category : #accessing }
FiMethod >> selector [

	^ selector ifNil: [ 
		selector := RBParser parseMethodPattern: sourceCode ]
]

{ #category : #accessing }
FiMethod >> sourceCode [
	
	^ sourceCode
]
