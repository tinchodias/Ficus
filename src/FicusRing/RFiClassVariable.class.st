"
I represent a class variable in a RFiClass.
"
Class {
	#name : #RFiClassVariable,
	#superclass : #RFiVariable,
	#category : #'FicusRing-Core'
}

{ #category : #accessing }
RFiClassVariable >> ficusPathFromEnvironment [

	^ definingClass environment ficusPathToClassVariable: self
]

{ #category : #printing }
RFiClassVariable >> shortPrintString [
	
	^ definingClass name, ' classVar: #', name 
]
