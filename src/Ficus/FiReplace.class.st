Class {
	#name : #FiReplace,
	#superclass : #FiEditEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiReplace >> oldValue [

	^ oldValue
]

{ #category : #accessing }
FiReplace >> oldValue: aValue [

	oldValue := aValue
]
