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
FiPackage >> classes [

	^ contents select: [ :each | each isFicusClass ]
]

{ #category : #accessing }
FiPackage >> contents [
	
	^ contents
]

{ #category : #accessing }
FiPackage >> defaultStep [

	^ theName asSymbol
]

{ #category : #accessing }
FiPackage >> extensionMethods [

	^ contents select: [ :each | each isFicusExtensionMethods ]
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
FiPackage >> traits [

	^ contents select: [ :each | each isFicusTrait ]
]
