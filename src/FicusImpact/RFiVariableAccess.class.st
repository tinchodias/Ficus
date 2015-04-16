Class {
	#name : #RFiVariableAccess,
	#superclass : #RFiRequisite,
	#instVars : [
		'variableName'
	],
	#category : #'FicusImpact-Requisites'
}

{ #category : #printing }
RFiVariableAccess >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: variableName;
		nextPut: $).
]

{ #category : #printing }
RFiVariableAccess >> shortPrintString [

	^ 'Access ', variableName
]

{ #category : #accessing }
RFiVariableAccess >> variableName [
	
	^ variableName
]
