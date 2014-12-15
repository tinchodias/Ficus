Class {
	#name : #FiVariableAccess,
	#superclass : #FiDependency,
	#instVars : [
		'variableName'
	],
	#category : #'FicusImpact-Dependencies'
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
