Class {
	#name : #FiSetEffect,
	#superclass : #FiEditEffect,
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #edits }
FiSetEffect >> exclude: aValue [

	^ FiExclude value: aValue
]

{ #category : #edits }
FiSetEffect >> include: aValue [

	^ FiInclude value: aValue
]
