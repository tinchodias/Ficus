Class {
	#name : #FiMetaclass,
	#superclass : #FiBehavior,
	#instVars : [
		'traitComposition'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #'instance creation' }
FiMetaclass class >> named: aString [ 
	^ self new
		theName: aString;
		yourself
		
]

{ #category : #initialization }
FiMetaclass >> initialize [

	super initialize.

	traitComposition := '{}'.
]

{ #category : #testing }
FiMetaclass >> isMeta [

	^ true
]

{ #category : #accessing }
FiMetaclass >> traitComposition [
	
	^ traitComposition
]

{ #category : #accessing }
FiMetaclass >> traitComposition: anObject [
	
	traitComposition := anObject
]
