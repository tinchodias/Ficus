"
I announce that a FiWorkingCopy has been refreshed.
"
Class {
	#name : #FiWorkingCopyRefreshed,
	#superclass : #Announcement,
	#instVars : [
		'workingCopy'
	],
	#category : #'FicusStore-WorkingCopies'
}

{ #category : #accessing }
FiWorkingCopyRefreshed >> workingCopy [
	^ workingCopy
]

{ #category : #accessing }
FiWorkingCopyRefreshed >> workingCopy: anObject [
	workingCopy := anObject
]
