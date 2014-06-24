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
	#category : #'Ficus-Model-Meta'
}

{ #category : #accessing }
FiPackage >> contents [
	
	^ contents
]

{ #category : #accessing }
FiPackage >> contents: anObject [
	
	contents := anObject
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

{ #category : #accessing }
FiPackage >> theName: anObject [
	
	theName := anObject
]
