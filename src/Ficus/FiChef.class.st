"
I am an object used for testing Ficus.
"
Class {
	#name : #FiChef,
	#superclass : #FiFixedObject,
	#instVars : [
		'admiredChefs',
		'recipes',
		'nickname',
		'shortBio'
	],
	#category : #'Ficus-Tests-Example'
}

{ #category : #'instance creation' }
FiChef class >> nickname: aString [ 

	^ self builder
		nickname: aString;
		new
]

{ #category : #'instance creation' }
FiChef class >> nickname: aString shortBio: anotherString [

	^ self builder
		nickname: aString;
		shortBio: anotherString;
		new
]

{ #category : #accessing }
FiChef >> admiredChefs [
	
	^ admiredChefs
]

{ #category : #accessing }
FiChef >> defaultStep [

	^ nickname asSymbol
]

{ #category : #initialization }
FiChef >> initialize [

	super initialize.

	shortBio := ''.
	admiredChefs := FiSet new.
	recipes := FiSet new.
]

{ #category : #accessing }
FiChef >> nickname [
	
	^ nickname
]

{ #category : #printing }
FiChef >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	nickname printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiChef >> recipes [
	
	^ recipes
]

{ #category : #accessing }
FiChef >> shortBio [

	^ shortBio
]
