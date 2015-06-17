"
I am an abstract superclass between Class and Metaclass in RingFicus. I am intended to be polymorphic with normal class and metaclass objects in the system.
"
Class {
	#name : #RFiAbstractClass,
	#superclass : #RFiBehavior,
	#instVars : [
		'cachedInstanceVariables'
	],
	#category : #'FicusRing-Core'
}

{ #category : #accessing }
RFiAbstractClass >> ficusClass [
	
	^ self subclassResponsibility
]

{ #category : #polymorphism }
RFiAbstractClass >> instanceVariables [

	^ (self ficusClass layout instanceVariables collect: #name) asArray
]

{ #category : #polymorphism }
RFiAbstractClass >> isBehavior [

	^ true
]

{ #category : #testing }
RFiAbstractClass >> isBits [
	"Answer whether the receiver contains just bits (not pointers)."

	^ self ficusClass layout isBitsLayout
]

{ #category : #testing }
RFiAbstractClass >> isVariable [
	"Answer whether the receiver has indexable variables."

	^ self ficusClass layout isVariableLayout
]

{ #category : #testing }
RFiAbstractClass >> isWeak [
	"Answer whether the receiver has contains weak references."
	^ self ficusClass layout isWeakLayout
]

{ #category : #testing }
RFiAbstractClass >> isWords [
	"Answer true if the receiver is made of 32-bit instance variables."

	^ self ficusClass layout isWordsLayout
]

{ #category : #accessing }
RFiAbstractClass >> ringInstanceVariableNamed: aString [

	^ self ringInstanceVariables detect: [ :each | each name = aString ]
]

{ #category : #accessing }
RFiAbstractClass >> ringInstanceVariables [ 

	^ cachedInstanceVariables ifNil: [
		cachedInstanceVariables := self instVarNames collect: [ :each |
			RFiInstanceVariable definingClass: self name: each ] ]
]

{ #category : #polymorphism }
RFiAbstractClass >> traitCompositionString [
	^ self ficusClass traitComposition
]
