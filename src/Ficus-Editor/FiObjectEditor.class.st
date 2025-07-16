Class {
	#name : #FiObjectEditor,
	#superclass : #Object,
	#instVars : [
		'base',
		'result'
	],
	#category : #'Ficus-Editor'
}

{ #category : #accessing }
FiObjectEditor >> base [

	^ base
]

{ #category : #initialization }
FiObjectEditor >> initializeForBase: aShot [ 
	
	self initialize.
	
	base := aShot.
	result := aShot.
]

{ #category : #accessing }
FiObjectEditor >> result [

	^ result
]
