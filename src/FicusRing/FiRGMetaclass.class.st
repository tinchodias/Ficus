"
I am polymorphic with Metaclass, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGMetaclass,
	#superclass : #FiRGBehavior,
	#instVars : [
		'theNonMetaClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #comparing }
FiRGMetaclass >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self theNonMetaClass = other theNonMetaClass
]

{ #category : #comparing }
FiRGMetaclass >> hash [

	^ self class hash bitXor: self theNonMetaClass hash
]

{ #category : #polymorphism }
FiRGMetaclass >> isMeta [

	^ true
]

{ #category : #'as yet unclassified' }
FiRGMetaclass >> methods [

	"FIX"
	^ theNonMetaClass shot metaclass methods values collect: [ :aMethodShot |
		self ringMethodFor: aMethodShot ]
]

{ #category : #polymorphism }
FiRGMetaclass >> theNonMetaClass [

	^ theNonMetaClass
]

{ #category : #accessing }
FiRGMetaclass >> theNonMetaClass: aFiRGClass [ 

	theNonMetaClass := aFiRGClass
]
