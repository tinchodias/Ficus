Class {
	#name : #EFiMethodUpdate,
	#superclass : #EFiMethodEdit,
	#instVars : [
		'selector',
		'edit'
	],
	#category : #'EpiceaFicus-Edits'
}

{ #category : #accessing }
EFiMethodUpdate >> edit [
	^ edit
]

{ #category : #results }
EFiMethodUpdate >> resultOn: aFiEnvironment [ 

	^ aFiEnvironment resultOfMethodUpdate: self
]

{ #category : #accessing }
EFiMethodUpdate >> selector [
	^ selector
]
