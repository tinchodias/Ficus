"
I represent a variable in a RFiBehavior.
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
RFiVariable class >> definingClass: aRFiBehavior name: aString [ 
	
	^ self basicNew
		initializeWithDefiningClass: aRFiBehavior name: aString;
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
RFiVariable >> initializeWithDefiningClass: aRFiBehavior name: aString [ 

	self initialize.
	
	definingClass := aRFiBehavior.
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
