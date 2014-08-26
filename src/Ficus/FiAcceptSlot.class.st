Class {
	#name : #FiAcceptSlot,
	#superclass : #FiEdit,
	#instVars : [
		'slotName',
		'edit'
	],
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #'instance creation' }
FiAcceptSlot class >> slotName: aSlotName edit: aEdit [
	
	^ self builder
		slotName: aSlotName;
		edit: aEdit;
		new
]

{ #category : #accessing }
FiAcceptSlot >> edit [

	^ edit
]

{ #category : #effects }
FiAcceptSlot >> effectOn: aValue [

	^ aValue effectOfAcceptSlot: self
]

{ #category : #effects }
FiAcceptSlot >> effectUpdate: oldValue [

	^ FiSlotUpdate builder
		slotName: slotName;
		oldValue: oldValue;
		newValue: (edit resultOn: oldValue);
		subEffect: (edit effectOn: oldValue);
		new
]

{ #category : #printing }
FiAcceptSlot >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(.

	self slotName printOn: aStream.

	aStream 
		nextPutAll: '->';
		nextPutAll: edit printString trimmed;
		nextPut: $).
]

{ #category : #results }
FiAcceptSlot >> resultOn: aValue [ 

	^ aValue resultOfAcceptSlot: self
	
]

{ #category : #accessing }
FiAcceptSlot >> slotName [
	
	^ slotName
]

{ #category : #accessing }
FiAcceptSlot >> step [
	
	^ slotName
]
