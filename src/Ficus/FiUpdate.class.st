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

{ #category : #printing }
FiUpdate >> newValueString [

	^ (newValue isShot 
		ifTrue: [ newValue values ]
		ifFalse: [ newValue ]) asString
]

{ #category : #accessing }
FiUpdate >> oldValue [
	
	^ oldValue
]

{ #category : #printing }
FiUpdate >> oldValueString [

	^ (oldValue isShot 
		ifTrue: [ oldValue values ]
		ifFalse: [ oldValue ]) asString
]
