"
I represent a trait.
"
Class {
	#name : #FiTrait,
	#superclass : #FiFixedObject,
	#instVars : [
		'methods',
		'category',
		'comment',
		'traitComposition',
		'name'
	],
	#category : #FicusMetamodel
}

{ #category : #'instance creation' }
FiTrait class >> named: aString [ 
	^ self new
		name: aString;
		yourself
		
]

{ #category : #accessing }
FiTrait >> category [

	^ category
]

{ #category : #accessing }
FiTrait >> comment [

	^ comment
]

{ #category : #accessing }
FiTrait >> defaultStep [

	^ name asSymbol
]

{ #category : #initialize }
FiTrait >> initialize [

	super initialize.

	name := nil.
	category := nil.
	comment := ''.
	traitComposition := '{}'.
	methods := FiDictionary new.
]

{ #category : #testing }
FiTrait >> isFicusClass [

	^ false
]

{ #category : #testing }
FiTrait >> isFicusExtensionMethods [

	^ false
]

{ #category : #testing }
FiTrait >> isFicusTrait [

	^ true
]

{ #category : #accessing }
FiTrait >> methods [
	
	^ methods
]

{ #category : #accessing }
FiTrait >> name [
	
	^ name
]

{ #category : #printing }
FiTrait >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	name printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiTrait >> traitComposition [
	
	^ traitComposition
]
