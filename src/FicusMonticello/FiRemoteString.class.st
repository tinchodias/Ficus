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
		self at: 1 put: self uncachedAsString ]
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

{ #category : #converting }
FiRemoteString >> uncachedAsString [
	
	| fileIndex filePosition |
	fileIndex := SourceFiles fileIndexFromSourcePointer: sourcePointer.
	filePosition := SourceFiles filePositionFromSourcePointer: sourcePointer.

	^ (RemoteString newFileNumber: fileIndex position: filePosition) string
]
