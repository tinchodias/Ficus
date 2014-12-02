"
I represent a set of extension methods in a package. 
"
Class {
	#name : #FiExtensionMethods,
	#superclass : #FiFixedObject,
	#instVars : [
		'hostName',
		'methods',
		'isMetaSide'
	],
	#category : #FicusMetamodel
}

{ #category : #accessing }
FiExtensionMethods >> defaultStep [

	^ 'Extensions to ', (isMetaSide 
		ifFalse: [ hostName ]
		ifTrue: [ hostName,  ' class' ]) asSymbol
]

{ #category : #accessing }
FiExtensionMethods >> hostName [
	
	^ hostName
]

{ #category : #testing }
FiExtensionMethods >> isFicusClass [

	^ false
]

{ #category : #testing }
FiExtensionMethods >> isFicusExtensionMethods [

	^ true
]

{ #category : #testing }
FiExtensionMethods >> isFicusTrait [

	^ false
]

{ #category : #accessing }
FiExtensionMethods >> isMetaSide [
	^ isMetaSide
]

{ #category : #accessing }
FiExtensionMethods >> methods [
	
	^ methods
]

{ #category : #printing }
FiExtensionMethods >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	self defaultStep printOn: aStream.
	aStream nextPut: $).
	
]
