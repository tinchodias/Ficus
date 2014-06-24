"
I represent an abstract FiBehavior's layout with slots.
"
Class {
	#name : #FiPointerLayout,
	#superclass : #FiLayout,
	#instVars : [
		'slotNames'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #initialization }
FiPointerLayout >> initialize [

	super initialize.

	slotNames := FiSet new
]

{ #category : #printing }
FiPointerLayout >> printOn: aStream [

	super printOn: aStream.

	slotNames values printElementsOn: aStream.
	
]

{ #category : #accessing }
FiPointerLayout >> slotNames [
	
	^ slotNames
]

{ #category : #accessing }
FiPointerLayout >> slotNames: anObject [
	
	slotNames := anObject
]
