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

{ #category : #effects }
FiFixedObjectAccept >> changeOn: aValue [

	^ aValue changeOfAcceptSlot: self
]

{ #category : #effects }
FiFixedObjectAccept >> changeUpdate: oldValue [

	^ FiFixedObjectUpdate builder
		slotName: slotName;
		oldValue: oldValue;
		newValue: (edit resultOn: oldValue);
		child: (edit changeOn: oldValue);
		new
]

{ #category : #accessing }
FiFixedObjectAccept >> edit [

	^ edit
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
