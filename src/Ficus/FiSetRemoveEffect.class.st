Class {
	#name : #FiSetRemoveEffect,
	#superclass : #FiSetEffect,
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiSetRemoveEffect >> edit [

	^ self exclude: theValue
]

{ #category : #accessing }
FiSetRemoveEffect >> inverse [

	^ self include: theValue
]
