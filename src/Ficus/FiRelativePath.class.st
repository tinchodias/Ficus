"
I represent a relative FiPath. I am composed by a basePath and a step.
"
Class {
	#name : #FiRelativePath,
	#superclass : #FiPath,
	#instVars : [
		'basePath',
		'step'
	],
	#category : #'Ficus-Model-Paths'
}

{ #category : #'instance creation' }
FiRelativePath class >> on: aPath step: anObject [ 
	^ self basicNew
		initializeOn: aPath
		step: anObject;
		yourself
]

{ #category : #comparing }
FiRelativePath >> = another [

	^ (self class = another class
		and: [ self basePath = another basePath ])
		and: [ self step = another step ]
]

{ #category : #accessing }
FiRelativePath >> basePath [

	^ basePath
]

{ #category : #comparing }
FiRelativePath >> hash [

	^ (self class hash 
		bitXor: self basePath hash)
		bitXor: self step hash
]

{ #category : #'initialize-release' }
FiRelativePath >> initializeOn: aPath step: anObject [ 

	self initialize.
	basePath := aPath.
	step := anObject.
	
	self assert: anObject isLiteral
]

{ #category : #printing }
FiRelativePath >> printOn: aStream [

	basePath printOn: aStream.
	aStream 
		nextPut: $/;
		nextPutAll: step asString.
]

{ #category : #resolving }
FiRelativePath >> resolvedOn: anObject [ 

	^ (basePath resolvedOn: anObject) valueAt: step
]

{ #category : #resolving }
FiRelativePath >> resolvedOn: anObject targetCollect: targetBlockClosure stepCollect: stepBlockClosure [ 
	
	^ stepBlockClosure 
		value: anObject
		value: step
		value: (basePath
			resolvedOn: (anObject valueAt: step)
			targetCollect: targetBlockClosure 
			stepCollect: stepBlockClosure)
]

{ #category : #accessing }
FiRelativePath >> step [

	^ step
]

{ #category : #accessing }
FiRelativePath >> steps [
	
	^ basePath steps copyWith: step
]

{ #category : #printing }
FiRelativePath >> storeOn: aStream [

	basePath storeOn: aStream.

	aStream nextPutAll: ' / '.
		
	step storeOn: aStream.
]
