Class {
	#name : #FiNoChange,
	#superclass : #FiChange,
	#category : #'Ficus-Model-Core-Changes'
}

{ #category : #converting }
FiNoChange >> asSimpleChangesAt: aBasePath [
	
	^ #() asFiSet
]

{ #category : #accessing }
FiNoChange >> edit [

	^ FiNoEdit new
]

{ #category : #accessing }
FiNoChange >> inverse [

	^ self edit
]

{ #category : #testing }
FiNoChange >> isNoChange [

	^ true
]
