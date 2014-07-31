"
I help on building FiShot subclasses. 

Example:

FiMethod builder
	protocol: #accessing;
	selector: #fortyTwo;
	new.
	
Will answer an instance of FiMethod where the protocol and the selector have the specified values. 
"
Class {
	#name : #FiShotBuilder,
	#superclass : #Object,
	#instVars : [
		'theClass',
		'stepsAndValues',
		'cache'
	],
	#category : #'Ficus-Model-Core'
}

{ #category : #'instance creation' }
FiShotBuilder class >> forClass: aClass [ 

	^ self basicNew
		initializeForClass: aClass;
		yourself
]

{ #category : #'reflective operations' }
FiShotBuilder >> doesNotUnderstand: aMessage [ 

	aMessage arguments size = 1 
		ifFalse: [ ^ super doesNotUnderstand: aMessage ].

	stepsAndValues 
		at: aMessage selector allButLast
		put: aMessage arguments first
]

{ #category : #initialization }
FiShotBuilder >> initializeForClass: aClass [

	super initialize.

	theClass := aClass.	
	stepsAndValues := Dictionary new.
	cache := FiShotCache default.
]

{ #category : #building }
FiShotBuilder >> new [

	| newInstance |
	newInstance := theClass newFromStepsAndValues: stepsAndValues.
	
	^ cache like: newInstance
]
