Class {
	#name : #FiNoEdit,
	#superclass : #FiEdit,
	#category : #'Ficus-Updates-Edits'
}

{ #category : #testing }
FiNoEdit >> isNoEdit [

	^ true
]

{ #category : #results }
FiNoEdit >> resultOn: aValue [
	"Do nothing"
	
	^ aValue
]
