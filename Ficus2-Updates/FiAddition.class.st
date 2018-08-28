Class {
	#name : #FiAddition,
	#superclass : #FiSimpleChange,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus2-Updates-SimpleChanges'
}

{ #category : #testing }
FiAddition >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ addBlock cull: self
]

{ #category : #accessing }
FiAddition >> newValue [
	
	^ newValue
]
