Class {
	#name : #FiShotEditor,
	#superclass : #Object,
	#instVars : [
		'base',
		'result'
	],
	#category : #'FicusExtras-Model-Editors'
}

{ #category : #accessing }
FiShotEditor >> base [

	^ base
]

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
