Class {
	#name : #FiShotEditor,
	#superclass : #Object,
	#instVars : [
		'base',
		'result'
	],
	#category : #'Ficus-Model-Editors'
}

{ #category : #initialization }
FiShotEditor >> initializeForBase: aShot [ 
	
	self initialize.
	
	base := aShot.
	result := aShot.
]

{ #category : #accessing }
FiShotEditor >> result [

	^ result
]
