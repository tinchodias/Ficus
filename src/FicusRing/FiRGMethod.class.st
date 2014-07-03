"
I am polymorphic with CompilerMethod, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGMethod,
	#superclass : #FiRGShot,
	#instVars : [
		'environment',
		'shot',
		'methodClass'
	],
	#category : #FicusRing
}

{ #category : #polymorphism }
FiRGMethod >> environment [
	
	^ environment
]

{ #category : #accessing }
FiRGMethod >> environment: anObject [
	
	environment := anObject
]

{ #category : #polymorphism }
FiRGMethod >> messages [

	^ FiSentSelectorsCollector new
		in: [ :visitor | self parseTree acceptVisitor: visitor ];
		selectors.

]

{ #category : #polymorphism }
FiRGMethod >> methodClass [
	
	^ methodClass
]

{ #category : #accessing }
FiRGMethod >> methodClass: anObject [
	
	methodClass := anObject
]

{ #category : #polymorphism }
FiRGMethod >> parseTree [

	^(RBExplicitVariableParser 
		parseMethod: self sourceCode 
		onError: [ :msg :pos | ^ nil ]) methodClass: self methodClass.
	
]

{ #category : #polymorphism }
FiRGMethod >> selector [

	^ shot selector
]

{ #category : #accessing }
FiRGMethod >> shot [
	
	^ shot
]

{ #category : #accessing }
FiRGMethod >> shot: anObject [
	
	shot := anObject
]

{ #category : #polymorphism }
FiRGMethod >> sourceCode [

	^ shot sourceCode
]
