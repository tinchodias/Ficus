Class {
	#name : #FiSetAddEffect,
	#superclass : #FiSetEffect,
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiSetAddEffect >> edit [

	^ self include: theValue
]

{ #category : #accessing }
FiSetAddEffect >> inverse [

	^ self exclude: theValue
]
