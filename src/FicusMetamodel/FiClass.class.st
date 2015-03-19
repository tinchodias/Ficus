"
I represent a class.
"
Class {
	#name : #FiClass,
	#superclass : #FiBehavior,
	#instVars : [
		'metaclass',
		'classPool',
		'sharedPools',
		'category',
		'comment',
		'traitComposition',
		'superclassName',
		'name'
	],
	#category : #FicusMetamodel
}

{ #category : #'instance creation' }
FiClass class >> named: aString [ 

	^ self builder
		name: aString;
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

	^ name asSymbol
]

{ #category : #testing }
FiClass >> hasNullSuperclass [

	^ superclassName asSymbol == self class nullSuperclassName
]

{ #category : #initialize }
FiClass >> initialize [

	super initialize.

	name := #NoName.
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
FiClass >> isFicusExtensionMethods [

	^ false
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

{ #category : #accessing }
FiClass >> name [
	
	^ name
]

{ #category : #accessing }
FiClass >> name: a [
	
	self
]

{ #category : #printing }
FiClass >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	name printOn: aStream.
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
FiClass >> traitComposition [
	
	^ traitComposition
]
