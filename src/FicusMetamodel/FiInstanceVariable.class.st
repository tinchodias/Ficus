"
I represent an instance variable in a class. I have my name and my original index in the class.
"
Class {
	#name : #FiInstanceVariable,
	#superclass : #FiFixedObject,
	#instVars : [
		'index',
		'name',
		'slotType',
		'slotDefinition'
	],
	#category : #'FicusMetamodel-Core'
}

{ #category : #accessing }
FiInstanceVariable >> defaultStep [

	^ name asSymbol
]

{ #category : #accessing }
FiInstanceVariable >> index [

	^ index
]

{ #category : #accessing }
FiInstanceVariable >> name [

	^ name
]

{ #category : #printing }
FiInstanceVariable >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	name printOn: aStream.
	aStream nextPut: $@.
	index printOn: aStream.
	aStream nextPut: $).

]

{ #category : #accessing }
FiInstanceVariable >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
FiInstanceVariable >> slotDefinition: def [
	(self usesSpecialSlots: def)
		ifTrue: [ | slot |
			slot := Smalltalk compiler evaluate: def.
			name := slot name.
			slotType := slot class name.
			slotDefinition := def ]
		ifFalse: [ name := def asSymbol.
			slotType := #InstanceVariableSlot.
			slotDefinition := def ]
]

{ #category : #accessing }
FiInstanceVariable >> slotType [
	^ slotType
]

{ #category : #accessing }
FiInstanceVariable >> usesSpecialSlots: def [
	^ (def beginsWith:'#') or: [ def includes: Character space ]
	
]
