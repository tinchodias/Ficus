"
I represent an FiBehavior's layout with both named slots and *weak* indexed slots.
"
Class {
	#name : #FiWeakVariableLayout,
	#superclass : #FiPointerLayout,
	#category : #'FicusMetamodel-Core'
}

{ #category : #testing }
FiWeakVariableLayout >> isWeakLayout [

	^ true
]
