"
I represent a global variable defined in the environment.
"
Class {
	#name : #RFiGlobalVariable,
	#superclass : #RFiObject,
	#instVars : [
		'name',
		'environment'
	],
	#category : #'FicusRing-Core'
}

{ #category : #'instance creation' }
RFiGlobalVariable class >> newWithEnvironment: anEnvironment name: aName [

	^ self basicNew
		initializeWithEnvironment: anEnvironment 
		name: aName;
		yourself
]

{ #category : #accessing }
RFiGlobalVariable >> environment [

	^ environment
]

{ #category : #accessing }
RFiGlobalVariable >> ficusPathFromEnvironment [

	^ { #globalVariable. name } asFiPath
]

{ #category : #initialization }
RFiGlobalVariable >> initializeWithEnvironment: anEnvironment name: aName [

	self initialize.

	environment := anEnvironment.
	name := aName.
]

{ #category : #accessing }
RFiGlobalVariable >> name [

	^ name
]
