Class {
	#name : #EFiEpiceaRepository,
	#superclass : #EFiRepository,
	#instVars : [
		'fileReference',
		'ombuStore'
	],
	#category : #'EpiceaFicus-Repositories'
}

{ #category : #'as yet unclassified' }
EFiEpiceaRepository >> commitSnapshot: anObject priors: aCollection [ 

	| newEntry |
	newEntry := OmEntry content: anObject.
	
	self ombuStore newEntry: newEntry.
]

{ #category : #accessing }
EFiEpiceaRepository >> fileReference [
	^ fileReference
]

{ #category : #accessing }
EFiEpiceaRepository >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #'as yet unclassified' }
EFiEpiceaRepository >> newWorkingCopy [

	^ FiWorkingCopy new
		name: 'Epicea-Repository-WC';
"		snapshot: self snapshot;"
		priors: {};
		store: self;
		yourself.

]

{ #category : #'as yet unclassified' }
EFiEpiceaRepository >> ombuStore [

	^ ombuStore ifNil: [
		ombuStore := OmSessionStore newWithBaseLocator: fileReference ]
]
