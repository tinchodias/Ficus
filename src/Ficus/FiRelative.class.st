"
I represent a relative FiPath. I am composed by a basePath and a step.
"
Class {
	#name : #FiRelative,
	#superclass : #FiPath,
	#instVars : [
		'basePath',
		'step'
	],
	#category : #'Ficus-Paths'
}

{ #category : #'instance creation' }
FiRelative class >> on: aPath step: anObject [ 
	^ self basicNew
		initializeOn: aPath
		step: anObject;
		yourself
]

{ #category : #comparing }
FiRelative >> = another [

	^ (self class = another class
		and: [ self basePath = another basePath ])
		and: [ self step = another step ]
]

{ #category : #accessing }
FiRelative >> basePath [

	^ basePath
]

{ #category : #comparing }
FiRelative >> hash [

	^ (self class hash 
		bitXor: self basePath hash)
		bitXor: self step hash
]

{ #category : #'initialize-release' }
FiRelative >> initializeOn: aPath step: anObject [ 

	self initialize.
	basePath := aPath.
	step := anObject.
]

{ #category : #printing }
FiRelative >> printOn: aStream [

	basePath printOn: aStream.
	aStream 
		nextPut: $/;
		nextPutAll: step asString.
]

{ #category : #resolving }
FiRelative >> resolvedOn: anObject [ 

	^ (basePath resolvedOn: anObject) shotAt: step
]

{ #category : #resolving }
FiRelative >> resolvedOn: anObject targetCollect: targetBlockClosure stepCollect: stepBlockClosure [ 
	
	^ stepBlockClosure 
		value: anObject
		value: step
		value: (basePath
			resolvedOn: (anObject shotAt: step)
			targetCollect: targetBlockClosure 
			stepCollect: stepBlockClosure)
]

{ #category : #accessing }
FiRelative >> step [

	^ step
]

{ #category : #accessing }
FiRelative >> steps [
	
	^ basePath steps copyWith: step
]
