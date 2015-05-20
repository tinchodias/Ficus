"
I represent a package.
"
Class {
	#name : #FiPackage,
	#superclass : #FiFixedObject,
	#instVars : [
		'contents',
		'name'
	],
	#category : #'FicusMetamodel-Core'
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

	^ name asSymbol
]

{ #category : #accessing }
FiPackage >> extensionMethods [

	^ contents select: [ :each | each isFicusExtensionMethods ]
]

{ #category : #accessing }
FiPackage >> name [
	
	^ name
]

{ #category : #printing }
FiPackage >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	name printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiPackage >> traits [

	^ contents select: [ :each | each isFicusTrait ]
]
