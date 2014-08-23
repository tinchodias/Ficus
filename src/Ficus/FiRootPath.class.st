"
I represent the root of a FiPath.
"
Class {
	#name : #FiRootPath,
	#superclass : #FiPath,
	#classInstVars : [
		'instance'
	],
	#category : #'Ficus-Model-Paths'
}

{ #category : #'instance creation' }
FiRootPath class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #comparing }
FiRootPath >> = another [

	^ self class = another class
]

{ #category : #comparing }
FiRootPath >> hash [

	^ self class hash
]

{ #category : #printing }
FiRootPath >> printOn: aStream [

	aStream nextPutAll: 'root'
]

{ #category : #resolving }
FiRootPath >> resolvedOn: anObject [

	^ anObject
]

{ #category : #resolving }
FiRootPath >> resolvedOn: anObject targetCollect: targetBlockClosure stepCollect: stepBlockClosure [ 
	
	^ targetBlockClosure value: anObject
]

{ #category : #accessing }
FiRootPath >> steps [
	
	^ #()
]

{ #category : #printing }
FiRootPath >> storeOn: aStream [

	aStream 
		nextPutAll: FiPath name;
		nextPutAll: ' root'
]
