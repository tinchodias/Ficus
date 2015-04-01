Class {
	#name : #FiVariableAccess,
	#superclass : #FiRequisite,
	#instVars : [
		'variableName'
	],
	#category : #'FicusImpact-Requisites'
}

{ #category : #printing }
FiVariableAccess >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: variableName;
		nextPut: $).
]

{ #category : #printing }
FiVariableAccess >> shortPrintString [

	^ 'Access ', variableName
]

{ #category : #accessing }
FiVariableAccess >> variableName [
	
	^ variableName
]
