"
I represent an instance variable in a either a class or metaclass.
"
Class {
	#name : #RFiInstanceVariable,
	#superclass : #RFiVariable,
	#category : #'FicusRing-Core'
}

{ #category : #accessing }
RFiInstanceVariable >> asMetamodelSpot [

	^ definingClass asMetamodelSpot / #layout / #instanceVariables / self name
]

{ #category : #printing }
RFiInstanceVariable >> shortPrintString [
	
	^ definingClass name, ' instVar: #', name 
]
