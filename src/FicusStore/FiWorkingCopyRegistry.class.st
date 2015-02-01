"
I am a registry of working copies.
"
Class {
	#name : #FiWorkingCopyRegistry,
	#superclass : #Object,
	#instVars : [
		'workingCopies'
	],
	#category : #'FicusStore-WorkingCopies'
}

{ #category : #accessing }
FiWorkingCopyRegistry >> addWorkingCopy: aFiStore [ 
	
	workingCopies add: aFiStore 
]

{ #category : #ui }
FiWorkingCopyRegistry >> browse [

	^ FiWorkingCopyRegistryBrowser openWith: self
]

{ #category : #initialization }
FiWorkingCopyRegistry >> initialize [

	super initialize.
	
	workingCopies := OrderedCollection new.
]

{ #category : #refreshing }
FiWorkingCopyRegistry >> refresh [
	
	"workingCopies do: #refresh"
]

{ #category : #accessing }
FiWorkingCopyRegistry >> workingCopies [

	^ workingCopies
]
