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

{ #category : #refreshing }
FiWorkingCopy >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #operations }
FiWorkingCopy >> applyEdit: anEdit [

	snapshot := (snapshot resultOf: anEdit).

	self announcer announce: 
		(FiWorkingCopyEdited new
			workingCopy: self;
			edit: anEdit;
			yourself)
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
		
	self announcer announce: 
		(FiWorkingCopyCommitted new
			workingCopy: self;
			yourself)
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

	self flag: #todo "first?".

	^ priors isEmpty
		ifTrue: [ true ]
		ifFalse: [ snapshot ~= priors anyOne snapshot ]
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
	
	self announcer announce: 
		(FiWorkingCopySettedSnapshot new
			workingCopy: self;
			yourself)
]

{ #category : #accessing }
FiWorkingCopy >> store [
	
	^ store
]

{ #category : #accessing }
FiWorkingCopy >> store: anObject [
	
	store := anObject
]
