Class {
	#name : #FiSetUpdate,
	#superclass : #FiSetChange,
	#instVars : [
		'newValue',
		'oldValue',
		'child'
	],
	#category : #'Ficus-Model-Core-Changes'
}

{ #category : #converting }
FiSetUpdate >> asSimpleChangesAt: aBasePath [

	^ { FiUpdate builder 
			path: aBasePath / newValue defaultStep;
			oldValue: oldValue; 
			newValue: newValue; 
			children: (child asSimpleChangesAt: aBasePath / newValue defaultStep);
			new } asFiSet
]

{ #category : #accessing }
FiSetUpdate >> child [

	^ child
]

{ #category : #accessing }
FiSetUpdate >> edit [
	
	self flag: #todo. "Answer a SubEdit when there is a child like FiFixedObjectUpdate"
	^ FiInclude value: newValue
]

{ #category : #accessing }
FiSetUpdate >> inverse [

	^ FiInclude value: oldValue
]

{ #category : #accessing }
FiSetUpdate >> newValue [

	^ newValue
]

{ #category : #accessing }
FiSetUpdate >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiSetUpdate >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: (child printStringLimitedTo: 30);
		nextPut: $).
]
