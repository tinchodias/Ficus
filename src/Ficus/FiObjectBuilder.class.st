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
	#name : #FiObjectBuilder,
	#superclass : #Object,
	#instVars : [
		'theClass',
		'stepsAndValues',
		'cache'
	],
	#category : #'Ficus-Model-Builder'
}

{ #category : #'instance creation' }
FiObjectBuilder class >> forClass: aClass [ 

	^ self basicNew
		initializeForClass: aClass;
		yourself
]

{ #category : #'reflective operations' }
FiObjectBuilder >> doesNotUnderstand: aMessage [ 

	aMessage arguments size = 1 
		ifFalse: [ ^ super doesNotUnderstand: aMessage ].

	stepsAndValues 
		at: aMessage selector allButLast
		put: aMessage arguments first
]

{ #category : #initialization }
FiObjectBuilder >> initializeForClass: aClass [

	super initialize.

	theClass := aClass.	
	stepsAndValues := Dictionary new.
	cache := FiObjectCache default.
]

{ #category : #building }
FiObjectBuilder >> new [

	| newInstance |
	newInstance := theClass newFromStepsAndValues: stepsAndValues.
	
	^ cache like: newInstance
]
