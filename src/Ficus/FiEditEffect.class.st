"
I represent an abstract edit effect on a shot. FiEdits know how to create effects.
"
Class {
	#name : #FiEditEffect,
	#superclass : #FiFixedObject,
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
