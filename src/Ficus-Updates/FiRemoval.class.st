Class {
	#name : #FiRemoval,
	#superclass : #FiSimpleChange,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Updates-SimpleChanges'
}

{ #category : #testing }
FiRemoval >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ removeBlock cull: self
]

{ #category : #accessing }
FiRemoval >> oldValue [
	
	^ oldValue
]
