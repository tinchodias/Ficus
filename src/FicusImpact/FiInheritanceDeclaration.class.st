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

{ #category : #printing }
FiInheritanceDeclaration >> shortPrintString [

	^ 'Subclass of ', theClassName
]

{ #category : #accessing }
FiInheritanceDeclaration >> theClassName [
	
	^ theClassName
]
