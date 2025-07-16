Class {
	#name : #FiAddition,
	#superclass : #FiSimpleChange,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Updates-SimpleChanges'
}

{ #category : #testing }
FiAddition >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ addBlock cull: self
]

{ #category : #accessing }
FiAddition >> newValue [
	
	^ newValue
]
