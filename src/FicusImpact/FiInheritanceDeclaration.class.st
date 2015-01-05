Class {
	#name : #FiInheritanceDeclaration,
	#superclass : #FiRequisite,
	#instVars : [
		'theClassName'
	],
	#category : #'FicusImpact-Requisites'
}

{ #category : #printing }
FiInheritanceDeclaration >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: theClassName;
		nextPut: $).
]

{ #category : #accessing }
FiInheritanceDeclaration >> theClassName [
	
	^ theClassName
]
