"
I represent an instance variable in a either a class or metaclass.
"
Class {
	#name : #FiRGInstanceVariable,
	#superclass : #FiRGVariable,
	#category : #'FicusRing-Core'
}

{ #category : #printing }
FiRGInstanceVariable >> shortPrintString [
	
	^ definingClass name, ' instVar: #', name 
]
