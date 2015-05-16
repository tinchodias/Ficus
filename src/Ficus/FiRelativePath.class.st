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

{ #category : #converting }
FiRelativePath >> asPathOn: anObject [

	^ (basePath asPathOn: anObject) / step
]

{ #category : #printing }
FiRelativePath >> asShortPrintStrings [

	^ basePath asShortPrintStrings copyWith: step
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
FiRelativePath >> resolvedOn: anObject ifAbsent: absentBlockClosure [ 

	| target |
	target := basePath 
		resolvedOn: anObject 
		ifAbsent: absentBlockClosure.
		
	^ target
		valueAt: step 
		ifPresent: [ :value | value ]
		ifAbsent: [ absentBlockClosure cull: basePath ]
]

{ #category : #resolving }
FiRelativePath >> resolvedOn: anObject ifPresent: presentBlockClosure ifAbsent: absentBlockClosure [ 

	| target |
	target := self 
		resolvedOn: anObject 
		ifAbsent: [ :resolvedSubPath | ^ absentBlockClosure cull: resolvedSubPath ].
	
	^ presentBlockClosure cull: target
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
