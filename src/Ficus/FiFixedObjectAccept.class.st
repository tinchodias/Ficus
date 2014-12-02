Class {
	#name : #FiFixedObjectAccept,
	#superclass : #FiEdit,
	#instVars : [
		'slotName',
		'edit'
	],
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #'instance creation' }
FiFixedObjectAccept class >> slotName: aSlotName edit: aEdit [
	
	^ self builder
		slotName: aSlotName;
		edit: aEdit;
		new
]

{ #category : #accessing }
FiFixedObjectAccept >> edit [

	^ edit
]

{ #category : #effects }
FiFixedObjectAccept >> effectOn: aValue [

	^ aValue effectOfAcceptSlot: self
]

{ #category : #effects }
FiFixedObjectAccept >> effectUpdate: oldValue [

	^ FiFixedObjectUpdate builder
		slotName: slotName;
		oldValue: oldValue;
		newValue: (edit resultOn: oldValue);
		subEffect: (edit effectOn: oldValue);
		new
]

{ #category : #printing }
FiFixedObjectAccept >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(.

	self slotName printOn: aStream.

	aStream 
		nextPutAll: '->';
		nextPutAll: edit printString trimmed;
		nextPut: $).
]

{ #category : #results }
FiFixedObjectAccept >> resultOn: aValue [ 

	^ aValue resultOfAcceptSlot: self
	
]

{ #category : #accessing }
FiFixedObjectAccept >> slotName [
	
	^ slotName
]

{ #category : #accessing }
FiFixedObjectAccept >> step [
	
	^ slotName
]
