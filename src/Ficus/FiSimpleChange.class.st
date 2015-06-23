Class {
	#name : #FiSimpleChange,
	#superclass : #FiFixedObject,
	#instVars : [
		'path',
		'children'
	],
	#category : #'Ficus-Model-Core-SimpleChanges'
}

{ #category : #accessing }
FiSimpleChange >> changeAt: aPath ifAbsent: absentBlockClosure [ 

	path = aPath
		ifTrue: [ ^ self ].
	
	(aPath beginsWith: path)
		ifFalse: [ ^ absentBlockClosure value ].
	
	children do: [ :child |
		(child
			changeAt: aPath 
			ifAbsent: [ nil ])
			ifNotNil: [ :change | ^ change ] ].
	
	^ absentBlockClosure value
]

{ #category : #accessing }
FiSimpleChange >> children [

	^ children
]

{ #category : #testing }
FiSimpleChange >> hasChangeAt: aPath [

	self
		changeAt: aPath 
		ifAbsent: [ ^ false ].
	
	^ true
]

{ #category : #testing }
FiSimpleChange >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ self subclassResponsibility 
]

{ #category : #enumerating }
FiSimpleChange >> leavesDo: aBlockClosure [
	
	^ children values
		ifEmpty: [ aBlockClosure value: self ]
		ifNotEmpty: [ children do: [ :each | each leavesDo: aBlockClosure ] ].
]

{ #category : #accessing }
FiSimpleChange >> path [
	
	^ path
]

{ #category : #printing }
FiSimpleChange >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: path;
		nextPut: $).
]

{ #category : #accessing }
FiSimpleChange >> relevantSimpleChanges [
	
	^ Array streamContents: [ :stream |
		self relevantSimpleChangesDo: [ :each | stream nextPut: each ] ]
]

{ #category : #enumerating }
FiSimpleChange >> relevantSimpleChangesDo: aBlockClosure [
	
	^ aBlockClosure value: self
]
