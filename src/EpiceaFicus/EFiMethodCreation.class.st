Class {
	#name : #EFiMethodCreation,
	#superclass : #EFiMethodEdit,
	#instVars : [
		'newMethod'
	],
	#category : #'EpiceaFicus-Edits'
}

{ #category : #accessing }
EFiMethodCreation >> newMethod [
	^ newMethod
]

{ #category : #results }
EFiMethodCreation >> resultOn: aFiEnvironment [ 
	
	^ aFiEnvironment resultOfMethodCreation: self
]
