Class {
	#name : #FiRemoval,
	#superclass : #FiSimpleEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Core-SimpleEffects'
}

{ #category : #testing }
FiRemoval >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ removeBlock cull: self
]

{ #category : #accessing }
FiRemoval >> oldValue [
	
	^ oldValue
]

{ #category : #printing }
FiRemoval >> oldValueString [

	^ oldValue asString
]
