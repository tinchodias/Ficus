"
I announce that a FiWorkingCopy has been refreshed.
"
Class {
	#name : #FiWorkingCopyRefreshed,
	#superclass : #Announcement,
	#instVars : [
		'target'
	],
	#category : #'FicusStore-WorkingCopies'
}

{ #category : #'instance creation' }
FiWorkingCopyRefreshed class >> target: aWorkingCopy [ 

	^ self basicNew
		initializeWithTarget: aWorkingCopy;
		yourself
]

{ #category : #initialization }
FiWorkingCopyRefreshed >> initializeWithTarget: aWorkingCopy [

	self initialize.
	
	target := aWorkingCopy
]

{ #category : #accessing }
FiWorkingCopyRefreshed >> target [

	^ target
]
