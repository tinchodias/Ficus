Class {
	#name : #FiNoEdit,
	#superclass : #FiEdit,
	#category : #'Ficus2-Updates-Edits'
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
