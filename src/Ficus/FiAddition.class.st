Class {
	#name : #FiAddition,
	#superclass : #FiSimpleEffect,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Model-Core-SimpleEffects'
}

{ #category : #testing }
FiAddition >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ addBlock cull: self
]

{ #category : #accessing }
FiAddition >> newValue [
	
	^ newValue
]
