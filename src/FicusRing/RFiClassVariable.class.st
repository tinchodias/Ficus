"
I represent a class variable in a RFiClass.
"
Class {
	#name : #RFiClassVariable,
	#superclass : #RFiVariable,
	#category : #'FicusRing-Core'
}

{ #category : #accessing }
RFiClassVariable >> asMetamodelSpot [

	^ definingClass asMetamodelSpot / #classPool / self name
]

{ #category : #printing }
RFiClassVariable >> shortPrintString [
	
	^ definingClass name, ' classVar: #', name 
]
