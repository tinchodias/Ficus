Class {
	#name : #EFiRevision,
	#superclass : #Object,
	#instVars : [
		'name',
		'repository'
	],
	#category : #'EpiceaFicus-Repositories'
}

{ #category : #comparing }
EFiRevision >> = other [

	^ self class == other class
		and: [ self name= other name
		and: [ self store = other store ] ]
]

{ #category : #accessing }
EFiRevision >> author [

	^ self subclassResponsibility
]

{ #category : #accessing }
EFiRevision >> deltas [

	^ self subclassResponsibility
]

{ #category : #printing }
EFiRevision >> ficusInspectorDefinitionString [

	^ self printString
]

{ #category : #comparing }
EFiRevision >> hash [

	^ (self class hash
		bitXor: self name hash)
		bitXor: self store hash
]

{ #category : #accessing }
EFiRevision >> message [

	^ self subclassResponsibility
]

{ #category : #accessing }
EFiRevision >> name [

	^ name
]

{ #category : #accessing }
EFiRevision >> name: anObject [

	name := anObject
]

{ #category : #'working copies' }
EFiRevision >> newWorkingCopy [
	"Checkout"
	
	^ FiWorkingCopy new
		name: name;
		snapshot: self snapshot;
		priors: { self };
		store: self repository;
		yourself.

]

{ #category : #printing }
EFiRevision >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: name printString;
		nextPut: $).
	
]

{ #category : #accessing }
EFiRevision >> priors [

	^ self subclassResponsibility
]

{ #category : #accessing }
EFiRevision >> repository [

	^ repository
]

{ #category : #accessing }
EFiRevision >> repository: anObject [

	repository := anObject
]

{ #category : #accessing }
EFiRevision >> snapshot [
	self flag: #todo. "decouple from FiEnvironmentSpot..."

	^ repository snapshotAtSpot: FiEnvironmentSpot new commitName: name
]

{ #category : #accessing }
EFiRevision >> snapshotAt: aSpot [

	^ self subclassResponsibility
]

{ #category : #accessing }
EFiRevision >> time [

	^ self subclassResponsibility
]
