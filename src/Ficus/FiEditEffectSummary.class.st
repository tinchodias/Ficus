Class {
	#name : #FiEditEffectSummary,
	#superclass : #FiFixedObject,
	#instVars : [
		'subSummary',
		'path'
	],
	#category : #'Ficus-UI-Model'
}

{ #category : #enumerating }
FiEditEffectSummary >> leavesDo: aBlockClosure [
	
	^ subSummary 
		ifEmpty: [ aBlockClosure value: self ]
		ifNotEmpty: [ subSummary do: [ :each | each leavesDo: aBlockClosure ] ].
]

{ #category : #printing }
FiEditEffectSummary >> newValueString [

	^ ''
]

{ #category : #printing }
FiEditEffectSummary >> oldValueString [

	^ ''
]

{ #category : #accessing }
FiEditEffectSummary >> path [
	
	^ path
]

{ #category : #printing }
FiEditEffectSummary >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: path;
		nextPut: $).
]

{ #category : #accessing }
FiEditEffectSummary >> subSummary [

	^ subSummary
]
