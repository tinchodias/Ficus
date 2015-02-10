"
I represent a working copy of a store. 

I know a snapshot, which is a FiShot, and a store, which is a FiStore. I'm dirty when my snapshot is different from the store's head.
"
Class {
	#name : #FiWorkingCopy,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'name',
		'priors',
		'snapshot',
		'store'
	],
	#category : #'FicusStore-WorkingCopies'
}

{ #category : #accessing }
FiWorkingCopy >> announceRefreshed [

	self announcer announce: (FiWorkingCopyRefreshed target: self)
]

{ #category : #refreshing }
FiWorkingCopy >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #converting }
FiWorkingCopy >> asHistoryNode [
	
	^ FiWorkingCopyHistoryNode new
		workingCopy: self;
		yourself
]

{ #category : #operations }
FiWorkingCopy >> commit: aString [ 

	| newNode |
	self flag: #todo. "message is ignored"
	
	newNode := store 
		commitSnapshot: snapshot 
		priors: priors. 
	
	priors := { newNode } asFiSet.
		
	self announceRefreshed.
]

{ #category : #operations }
FiWorkingCopy >> delta [

	priors size = 1 ifFalse: [ self notYetImplemented ].

	^ snapshot differenceFrom: priors anyOne snapshot
]

{ #category : #printing }
FiWorkingCopy >> description [
	
	^ String streamContents: [ :stream | self printDescriptionOn: stream ]
]

{ #category : #testing }
FiWorkingCopy >> isDirty [

	^ snapshot ~= store headHistoryNode snapshot
]

{ #category : #accessing }
FiWorkingCopy >> name [
	
	^ name
]

{ #category : #accessing }
FiWorkingCopy >> name: anObject [
	
	name := anObject
]

{ #category : #printing }
FiWorkingCopy >> printDescriptionOn: aStream [

	aStream 
		nextPutAll: name.
	
	self isDirty ifTrue: [
		aStream nextPut: $* ].
]

{ #category : #printing }
FiWorkingCopy >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(.

	self printDescriptionOn: aStream.
		
	aStream 
		nextPut: $).

]

{ #category : #accessing }
FiWorkingCopy >> priors [
	^ priors
]

{ #category : #accessing }
FiWorkingCopy >> priors: anObject [
	priors := anObject
]

{ #category : #accessing }
FiWorkingCopy >> snapshot [
	
	^ snapshot
]

{ #category : #accessing }
FiWorkingCopy >> snapshot: anObject [
	
	snapshot := anObject.
	
	self announceRefreshed.
]

{ #category : #accessing }
FiWorkingCopy >> store [
	
	^ store
]

{ #category : #accessing }
FiWorkingCopy >> store: anObject [
	
	store := anObject
]
