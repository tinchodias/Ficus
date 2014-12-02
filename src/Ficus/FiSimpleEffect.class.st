Class {
	#name : #FiSimpleEffect,
	#superclass : #FiFixedObject,
	#instVars : [
		'path',
		'children'
	],
	#category : #'Ficus-Model-Core-SimpleEffects'
}

{ #category : #accessing }
FiSimpleEffect >> children [

	^ children
]

{ #category : #testing }
FiSimpleEffect >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ self subclassResponsibility 
]

{ #category : #enumerating }
FiSimpleEffect >> leavesDo: aBlockClosure [
	
	^ children 
		ifEmpty: [ aBlockClosure value: self ]
		ifNotEmpty: [ children do: [ :each | each leavesDo: aBlockClosure ] ].
]

{ #category : #printing }
FiSimpleEffect >> newValueString [

	^ ''
]

{ #category : #printing }
FiSimpleEffect >> oldValueString [

	^ ''
]

{ #category : #accessing }
FiSimpleEffect >> path [
	
	^ path
]

{ #category : #printing }
FiSimpleEffect >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: path;
		nextPut: $).
]
