Class {
	#name : #FiNoChange,
	#superclass : #FiChange,
	#category : #'Ficus-Updates-Changes'
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
