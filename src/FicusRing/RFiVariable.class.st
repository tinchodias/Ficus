"
I represent a variable in a FiRGBehavior.
"
Class {
	#name : #RFiVariable,
	#superclass : #RFiObject,
	#instVars : [
		'name',
		'definingClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #'instance creation' }
RFiVariable class >> definingClass: aFiRGBehavior name: aString [ 
	
	^ self basicNew
		initializeWithDefiningClass: aFiRGBehavior name: aString;
		yourself
]

{ #category : #accessing }
RFiVariable >> definingClass [
	
	^ definingClass
]

{ #category : #accessing }
RFiVariable >> environment [
	
	^ definingClass environment
]

{ #category : #initialization }
RFiVariable >> initializeWithDefiningClass: aFiRGBehavior name: aString [ 

	self initialize.
	
	definingClass := aFiRGBehavior.
	name := aString.
]

{ #category : #accessing }
RFiVariable >> name [
	^ name
]

{ #category : #accessing }
RFiVariable >> package [
	
	^ definingClass package
]

{ #category : #printing }
RFiVariable >> printOn: aStream [

	super printOn: aStream.
	
	aStream
		nextPut: $(;
		nextPutAll: self shortPrintString;
		nextPut: $).
]
