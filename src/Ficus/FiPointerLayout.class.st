Class {
	#name : #FiPointerLayout,
	#superclass : #FiLayout,
	#instVars : [
		'slotNames'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #accessing }
FiPointerLayout >> slotNames [
	
	^ slotNames
]

{ #category : #accessing }
FiPointerLayout >> slotNames: anObject [
	
	slotNames := anObject
]
