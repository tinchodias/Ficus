Class {
	#name : #FiFixedObjectUpdate,
	#superclass : #FiChange,
	#instVars : [
		'slotName',
		'newValue',
		'oldValue',
		'child'
	],
	#category : #'Ficus-Model-Core-Changes'
}

{ #category : #converting }
FiFixedObjectUpdate >> asSimpleChangesAt: aBasePath [

	^ { FiUpdate builder 
			path: aBasePath / slotName;
			oldValue: oldValue; 
			newValue: newValue; 
			children: (child asSimpleChangesAt: aBasePath / slotName);
			new } asFiSet
]

{ #category : #accessing }
FiFixedObjectUpdate >> child [

	^ child
]

{ #category : #accessing }
FiFixedObjectUpdate >> edit [

	^ FiFixedObjectAccept 
		slotName: slotName 
		edit: child edit
]

{ #category : #accessing }
FiFixedObjectUpdate >> inverse [

	^ FiFixedObjectAccept 
		slotName: slotName 
		edit: child inverse
]

{ #category : #accessing }
FiFixedObjectUpdate >> newValue [

	^ newValue
]

{ #category : #accessing }
FiFixedObjectUpdate >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiFixedObjectUpdate >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: slotName;
		nextPut: $).
]

{ #category : #accessing }
FiFixedObjectUpdate >> slotName [

	^ slotName
]
