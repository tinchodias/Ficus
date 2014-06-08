Class {
	#name : #FiMethod,
	#superclass : #FiShot,
	#instVars : [
		'protocol',
		'sourceCode',
		'selector'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #'instance creation' }
FiMethod class >> selector: aSelector sourceCode: aSourceCode protocol: aProtocol [
	
	^ self new
		selector: aSelector;
		sourceCode: aSourceCode;
		protocol: aProtocol;
		yourself
]

{ #category : #accessing }
FiMethod >> defaultStep [

	^ selector asSymbol
]

{ #category : #accessing }
FiMethod >> protocol [
	
	^ protocol
]

{ #category : #accessing }
FiMethod >> protocol: aString [ 

	protocol := aString
]

{ #category : #accessing }
FiMethod >> selector [
	^ selector
]

{ #category : #accessing }
FiMethod >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
FiMethod >> sourceCode [
	
	^ sourceCode
]

{ #category : #accessing }
FiMethod >> sourceCode: aString [ 

	sourceCode := aString
]
