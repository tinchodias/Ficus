"
I represent the root of a FiPath.
"
Class {
	#name : #FiRoot,
	#superclass : #FiPath,
	#classInstVars : [
		'instance'
	],
	#category : #'Ficus-Paths'
}

{ #category : #'instance creation' }
FiRoot class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #comparing }
FiRoot >> = another [

	^ self class = another class
]

{ #category : #comparing }
FiRoot >> hash [

	^ self class hash
]

{ #category : #printing }
FiRoot >> printOn: aStream [

	aStream nextPutAll: '/'
]

{ #category : #resolving }
FiRoot >> resolvedOn: anObject [

	^ anObject
]

{ #category : #resolving }
FiRoot >> resolvedOn: anObject targetCollect: targetBlockClosure stepCollect: stepBlockClosure [ 
	
	^ targetBlockClosure value: anObject
]

{ #category : #accessing }
FiRoot >> steps [
	
	^ #()
]
