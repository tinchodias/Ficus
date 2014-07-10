"
I represent a class.
"
Class {
	#name : #FiClass,
	#superclass : #FiBehavior,
	#instVars : [
		'theName',
		'metaclass',
		'classPool',
		'sharedPools',
		'category',
		'comment',
		'traitComposition',
		'superclassName'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #'instance creation' }
FiClass class >> named: aString [ 

	^ self builder
		theName: aString;
		new
]

{ #category : #'default values' }
FiClass class >> nullSuperclassName [
	
	^ #nil
]

{ #category : #accessing }
FiClass >> category [

	^ category
]

{ #category : #accessing }
FiClass >> classPool [
	
	^ classPool
]

{ #category : #accessing }
FiClass >> comment [

	^ comment
]

{ #category : #accessing }
FiClass >> defaultStep [

	^ theName asSymbol
]

{ #category : #testing }
FiClass >> hasNullSuperclass [

	^ superclassName == self class nullSuperclassName
]

{ #category : #initialize }
FiClass >> initialize [

	super initialize.

	theName := #NoName.
	superclassName := self class nullSuperclassName.
	category := #NoCategory.
	classPool := FiSet new.
	comment := ''.
	sharedPools := FiSet new.
	metaclass := FiMetaclass new.
	traitComposition := '{}'.
]

{ #category : #testing }
FiClass >> isFicusClass [

	^ true
]

{ #category : #testing }
FiClass >> isFicusTrait [

	^ false
]

{ #category : #testing }
FiClass >> isMeta [

	^ false
]

{ #category : #accessing }
FiClass >> metaclass [
	^ metaclass
]

{ #category : #printing }
FiClass >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	theName printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiClass >> sharedPools [
	
	^ sharedPools
]

{ #category : #accessing }
FiClass >> superclassName [
	
	^ superclassName
	
]

{ #category : #accessing }
FiClass >> theName [
	
	^ theName
]

{ #category : #accessing }
FiClass >> traitComposition [
	
	^ traitComposition
]
