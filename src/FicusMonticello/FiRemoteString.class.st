Class {
	#name : #FiRemoteString,
	#superclass : #Object,
	#type : #weak,
	#instVars : [
		'sourcePointer'
	],
	#category : #'FicusMonticello-RemoteString'
}

{ #category : #'instance creation' }
FiRemoteString class >> newFromSourcePointer: aSourcePointer [ 

	^ (self basicNew: 1)
		initializeFromSourcePointer: aSourcePointer;
		yourself
]

{ #category : #comparing }
FiRemoteString >> = other [

	^ self asString = other
]

{ #category : #converting }
FiRemoteString >> asString [
	
	^ (self at: 1) ifNil: [
		| fileIndex filePosition string |
		fileIndex := SourceFiles fileIndexFromSourcePointer: sourcePointer.
		filePosition := SourceFiles filePositionFromSourcePointer: sourcePointer.
		string := (RemoteString newFileNumber: fileIndex position: filePosition) string.

		self at: 1 put: string ]
]

{ #category : #comparing }
FiRemoteString >> hash [

	^ self asString hash
]

{ #category : #initialization }
FiRemoteString >> initializeFromSourcePointer: aSourcePointer [ 
	
	self initialize.
	
	sourcePointer := aSourcePointer.
]
