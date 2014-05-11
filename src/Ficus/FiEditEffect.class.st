Class {
	#name : #FiEditEffect,
	#superclass : #FiShot,
	#instVars : [
		'edit'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiEditEffect >> edit [

	^ edit
]

{ #category : #accessing }
FiEditEffect >> edit: anObject [

	edit := anObject
]

{ #category : #accessing }
FiEditEffect >> inverse [

	^ self subclassResponsibility 
]
