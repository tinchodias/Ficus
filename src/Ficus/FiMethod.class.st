Class {
	#name : #FiMethod,
	#superclass : #FiShot,
	#instVars : [
		'protocol',
		'sourceCode'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #'instance creation' }
FiMethod class >> sourceCode: aSourceCode protocol: aProtocol [
	
	^ self new
		sourceCode: aSourceCode;
		protocol: aProtocol;
		yourself
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
FiMethod >> sourceCode [
	
	^ sourceCode
]

{ #category : #accessing }
FiMethod >> sourceCode: aString [ 

	sourceCode := aString
]
