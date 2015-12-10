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

{ #category : #accessing }
FiVariableAccess >> variableName [
	
	^ variableName
]
