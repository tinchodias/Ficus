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
		'stepsAndValues'
	],
	#category : #'Ficus-Model-Core'
}

{ #category : #'instance creation' }
FiShotBuilder class >> forClass: aClass [ 

	^ self new
		theClass: aClass;
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
FiShotBuilder >> initialize [

	super initialize.
	
	stepsAndValues := Dictionary new.
]

{ #category : #building }
FiShotBuilder >> new [

	^ theClass newFromStepsAndValues: stepsAndValues
]

{ #category : #accessing }
FiShotBuilder >> theClass: aClass [ 
	
	theClass := aClass
]
