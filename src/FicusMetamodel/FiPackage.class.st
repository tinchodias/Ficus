"
I represent a package.
"
Class {
	#name : #FiPackage,
	#superclass : #FiFixedObject,
	#instVars : [
		'theName',
		'contents'
	],
	#category : #FicusMetamodel
}

{ #category : #accessing }
FiPackage >> contents [
	
	^ contents
]

{ #category : #accessing }
FiPackage >> defaultStep [

	^ theName asSymbol
]

{ #category : #printing }
FiPackage >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	theName printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiPackage >> theName [
	
	^ theName
]
