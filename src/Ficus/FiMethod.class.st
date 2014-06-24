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
	#category : #'Ficus-Model-Meta'
}

{ #category : #'instance creation' }
FiMethod class >> selector: aSelector sourceCode: aSourceCode protocol: aProtocol [
	
	^ self builder
		selector: aSelector;
		sourceCode: aSourceCode;
		protocol: aProtocol;
		new
]

{ #category : #accessing }
FiMethod >> defaultStep [

	^ selector asSymbol
]

{ #category : #printing }
FiMethod >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	selector printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiMethod >> protocol [
	
	^ protocol
]

{ #category : #accessing }
FiMethod >> selector [
	^ selector
]

{ #category : #accessing }
FiMethod >> sourceCode [
	
	^ sourceCode
]
