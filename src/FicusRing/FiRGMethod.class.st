"
I am polymorphic with CompilerMethod, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGMethod,
	#superclass : #FiRGShot,
	#instVars : [
		'shot',
		'ringEnvironment',
		'ringMethodClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #polymorphism }
FiRGMethod >> environment [
	
	^ ringEnvironment
]

{ #category : #polymorphism }
FiRGMethod >> messages [

	^ FiSentSelectorsCollector new
		in: [ :visitor | self parseTree acceptVisitor: visitor ];
		selectors.

]

{ #category : #polymorphism }
FiRGMethod >> methodClass [
	
	^ ringMethodClass
]

{ #category : #polymorphism }
FiRGMethod >> parseTree [

	^(RBExplicitVariableParser 
		parseMethod: self sourceCode 
		onError: [ :msg :pos | ^ nil ]) methodClass: self methodClass.
	
]

{ #category : #accessing }
FiRGMethod >> ringEnvironment: anObject [
	
	ringEnvironment := anObject
]

{ #category : #accessing }
FiRGMethod >> ringMethodClass: anObject [
	
	ringMethodClass := anObject
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
