Class {
	#name : #FiUpdate,
	#superclass : #FiSimpleChange,
	#instVars : [
		'newValue',
		'oldValue'
	],
	#category : #'Ficus-Model-Core-SimpleChanges'
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
FiUpdate >> relevantSimpleChangesDo: aBlockClosure [

	^ children values
		ifEmpty: [ aBlockClosure value: self ]
		ifNotEmpty: [ children do: [ :each | each relevantSimpleChangesDo: aBlockClosure ] ]
]
