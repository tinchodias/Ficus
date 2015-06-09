Class {
	#name : #FiWorkingCopyEdited,
	#superclass : #FiWorkingCopyRefreshed,
	#instVars : [
		'edit'
	],
	#category : #'FicusStore-WorkingCopies'
}

{ #category : #accessing }
FiWorkingCopyEdited >> edit [
	^ edit
]

{ #category : #accessing }
FiWorkingCopyEdited >> edit: anObject [
	edit := anObject
]

{ #category : #printing }
FiWorkingCopyEdited >> printOn: aStream [

	super printOn: aStream.
	
	aStream
		nextPut: $(;
		print: edit;
		nextPut: $).
]
