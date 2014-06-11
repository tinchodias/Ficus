Class {
	#name : #FiAcceptSlot,
	#superclass : #FiEdit,
	#instVars : [
		'slotName',
		'edit'
	],
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiAcceptSlot class >> slotName: aSlotName edit: aEdit [
	
	^ self new
		slotName: aSlotName;
		edit: aEdit;
		yourself
]

{ #category : #accessing }
FiAcceptSlot >> edit [

	^ edit
]

{ #category : #accessing }
FiAcceptSlot >> edit: anObject [

	edit := anObject
]

{ #category : #effects }
FiAcceptSlot >> effectOn: aValue [

	^ aValue effectOfAcceptSlot: self
]

{ #category : #effects }
FiAcceptSlot >> effectUpdate: oldValue [

	^ FiUpdateEffect new
		edit: self;
		oldValue: oldValue;
		subEffect: (edit effectOn: oldValue);
		yourself
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
FiAcceptSlot >> slotName: anObject [
	
	slotName := anObject
]
