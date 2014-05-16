Class {
	#name : #FiClass,
	#superclass : #FiBehavior,
	#instVars : [
		'theName',
		'metaclass',
		'superclass',
		'classPool',
		'sharedPools',
		'category',
		'comment',
		'traitComposition'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #'instance creation' }
FiClass class >> named: aString [ 
	^ self new
		theName: aString;
		yourself
		
]

{ #category : #accessing }
FiClass >> category [

	^ category
]

{ #category : #accessing }
FiClass >> category: anObject [

	category := anObject
]

{ #category : #accessing }
FiClass >> classPool [
	
	^ classPool
]

{ #category : #accessing }
FiClass >> classPool: anObject [
	
	classPool := anObject
]

{ #category : #accessing }
FiClass >> comment [

	^ comment
]

{ #category : #accessing }
FiClass >> comment: anObject [

	comment := anObject
]

{ #category : #initialize }
FiClass >> initialize [

	super initialize.

	theName := nil.
	category := nil.
	classPool := #().
	comment := ''.
	sharedPools := FiSet new.
	metaclass := FiMetaclass new.
	traitComposition := '{}'.
]

{ #category : #testing }
FiClass >> isMeta [

	^ false
]

{ #category : #testing }
FiClass >> isTrait [

	^ false
]

{ #category : #accessing }
FiClass >> metaclass [
	^ metaclass
]

{ #category : #accessing }
FiClass >> metaclass: anObject [
	metaclass := anObject
]

{ #category : #printing }
FiClass >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	self theName printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiClass >> sharedPools [
	
	^ sharedPools
]

{ #category : #accessing }
FiClass >> sharedPools: anObject [
	
	sharedPools := anObject
]

{ #category : #accessing }
FiClass >> superclass [
	
	^ superclass
]

{ #category : #accessing }
FiClass >> superclass: anObject [
	
	superclass := anObject
]

{ #category : #accessing }
FiClass >> theName [
	
	^ theName
]

{ #category : #accessing }
FiClass >> theName: anObject [
	
	theName := anObject
]

{ #category : #accessing }
FiClass >> traitComposition [
	
	^ traitComposition
]

{ #category : #accessing }
FiClass >> traitComposition: anObject [
	
	traitComposition := anObject
]
