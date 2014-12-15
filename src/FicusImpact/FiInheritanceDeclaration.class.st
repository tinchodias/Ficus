Class {
	#name : #FiInheritanceDeclaration,
	#superclass : #FiDependency,
	#instVars : [
		'theClassName'
	],
	#category : #'FicusImpact-Dependencies'
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
