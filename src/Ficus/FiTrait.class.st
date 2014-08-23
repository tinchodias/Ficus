"
I represent a trait.
"
Class {
	#name : #FiTrait,
	#superclass : #FiFixedObject,
	#instVars : [
		'theName',
		'methods',
		'category',
		'comment',
		'traitComposition'
	],
	#category : #'Ficus-Examples-Metamodel'
}

{ #category : #'instance creation' }
FiTrait class >> named: aString [ 
	^ self new
		theName: aString;
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

	^ theName asSymbol
]

{ #category : #initialize }
FiTrait >> initialize [

	super initialize.

	theName := nil.
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
FiTrait >> isFicusTrait [

	^ true
]

{ #category : #accessing }
FiTrait >> methods [
	
	^ methods
]

{ #category : #printing }
FiTrait >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	theName printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiTrait >> theName [
	
	^ theName
]

{ #category : #accessing }
FiTrait >> traitComposition [
	
	^ traitComposition
]
