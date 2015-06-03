"
I represent a trait or a class trait. I have some common implementation of them.
"
Class {
	#name : #FiAbstractTrait,
	#superclass : #FiFixedObject,
	#instVars : [
		'methods',
		'traitComposition'
	],
	#category : #'FicusMetamodel-Core'
}

{ #category : #'as yet unclassified' }
FiAbstractTrait >> initialize [

	super initialize.
	traitComposition := '{}'.
	methods := FiSet new.
]

{ #category : #testing }
FiAbstractTrait >> isFicusClass [

	^ false
]

{ #category : #testing }
FiAbstractTrait >> isFicusExtensionMethods [

	^ false
]

{ #category : #testing }
FiAbstractTrait >> isFicusTrait [

	^ true
]

{ #category : #accessing }
FiAbstractTrait >> methods [
	
	^ methods
]

{ #category : #accessing }
FiAbstractTrait >> traitComposition [
	
	^ traitComposition
]
