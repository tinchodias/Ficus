Class {
	#name : #FiUpdate,
	#superclass : #FiSimpleEffect,
	#instVars : [
		'newValue',
		'oldValue'
	],
	#category : #'Ficus-Model-Core-SimpleEffects'
}

{ #category : #testing }
FiUpdate >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ updateBlock cull: self
]

{ #category : #accessing }
FiUpdate >> newValue [
	
	^ newValue
]

{ #category : #accessing }
FiUpdate >> oldValue [
	
	^ oldValue
]

{ #category : #enumerating }
FiUpdate >> relevantSimpleEffectsDo: aBlockClosure [

	^ children values
		ifEmpty: [ aBlockClosure value: self ]
		ifNotEmpty: [ children do: [ :each | each relevantSimpleEffectsDo: aBlockClosure ] ]
]
