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

{ #category : #accessing }
FiSimpleEffect >> effectAt: aPath ifAbsent: absentBlockClosure [ 

	path = aPath
		ifTrue: [ ^ self ].
	
	(aPath beginsWith: path)
		ifFalse: [ ^ absentBlockClosure value ].
	
	children do: [ :child |
		(child
			effectAt: aPath 
			ifAbsent: [ nil ])
			ifNotNil: [ :effect | ^ effect ] ].
	
	^ absentBlockClosure value
]

{ #category : #testing }
FiSimpleEffect >> hasEffectAt: aPath [

	self
		effectAt: aPath 
		ifAbsent: [ ^ false ].
	
	^ true
]

{ #category : #testing }
FiSimpleEffect >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ self subclassResponsibility 
]

{ #category : #enumerating }
FiSimpleEffect >> leavesDo: aBlockClosure [
	
	^ children values
		ifEmpty: [ aBlockClosure value: self ]
		ifNotEmpty: [ children do: [ :each | each leavesDo: aBlockClosure ] ].
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
