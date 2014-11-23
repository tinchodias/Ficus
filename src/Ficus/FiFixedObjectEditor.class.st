Class {
	#name : #FiFixedObjectEditor,
	#superclass : #FiShotEditor,
	#category : #'Ficus-Model-Editors'
}

{ #category : #'instance creation' }
FiFixedObjectEditor class >> for: aShot [

	^ self basicNew
		initializeForBase: aShot;
		yourself
]

{ #category : #'reflective operations' }
FiFixedObjectEditor >> doesNotUnderstand: aMessage [ 

	aMessage arguments size = 1 
		ifFalse: [ ^ super doesNotUnderstand: aMessage ].

	result := result resultOf: 
		(result
			editAt: aMessage selector allButLast
			equal: aMessage arguments first).
]
