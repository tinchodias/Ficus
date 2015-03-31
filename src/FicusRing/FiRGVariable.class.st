"
I represent a variable in a FiRGBehavior.
"
Class {
	#name : #FiRGVariable,
	#superclass : #FiRGObject,
	#instVars : [
		'name',
		'definingClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #'instance creation' }
FiRGVariable class >> definingClass: aFiRGBehavior name: aString [ 
	
	^ self basicNew
		initializeWithDefiningClass: aFiRGBehavior name: aString;
		yourself
]

{ #category : #accessing }
FiRGVariable >> definingClass [
	
	^ definingClass
]

{ #category : #initialization }
FiRGVariable >> initializeWithDefiningClass: aFiRGBehavior name: aString [ 

	self initialize.
	
	definingClass := aFiRGBehavior.
	name := aString.
]

{ #category : #accessing }
FiRGVariable >> name [
	^ name
]

{ #category : #accessing }
FiRGVariable >> package [
	
	^ definingClass package
]
