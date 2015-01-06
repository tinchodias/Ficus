"
I am the abstract superclass of classes that are polymorphic with metamodel entities, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGObject,
	#superclass : #Object,
	#category : #'FicusRing-Core'
}

{ #category : #printing }
FiRGObject >> shortPrintString [

	^ self name
]
