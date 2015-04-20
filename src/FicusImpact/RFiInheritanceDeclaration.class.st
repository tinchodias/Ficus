Class {
	#name : #RFiInheritanceDeclaration,
	#superclass : #RFiRequisite,
	#instVars : [
		'theClassName'
	],
	#category : #'FicusImpact-Model'
}

{ #category : #printing }
RFiInheritanceDeclaration >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: theClassName;
		nextPut: $).
]

{ #category : #printing }
RFiInheritanceDeclaration >> shortPrintString [

	^ 'Subclass of ', theClassName
]

{ #category : #accessing }
RFiInheritanceDeclaration >> theClassName [
	
	^ theClassName
]
