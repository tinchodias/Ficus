Class {
	#name : #FiTrait,
	#superclass : #FiShot,
	#instVars : [
		'theName',
		'methods',
		'category',
		'comment',
		'traitComposition'
	],
	#category : #'Ficus-Model-Meta'
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
FiTrait >> category: anObject [

	category := anObject
]

{ #category : #accessing }
FiTrait >> comment [

	^ comment
]

{ #category : #accessing }
FiTrait >> comment: anObject [

	comment := anObject
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

{ #category : #accessing }
FiTrait >> methods: anObject [
	
	methods := anObject
]

{ #category : #printing }
FiTrait >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	self theName printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiTrait >> theName [
	
	^ theName
]

{ #category : #accessing }
FiTrait >> theName: anObject [
	
	theName := anObject
]

{ #category : #accessing }
FiTrait >> traitComposition [
	
	^ traitComposition
]

{ #category : #accessing }
FiTrait >> traitComposition: anObject [
	
	traitComposition := anObject
]
