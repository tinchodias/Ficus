"
I am a store that persists it's sole snapshot in a file system. I don't keep track of history.
"
Class {
	#name : #FiFlatStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'fileReference',
		'name',
		'soleSnapshot'
	],
	#category : #'FicusStore-Stores'
}

{ #category : #accessing }
FiFlatStore >> commitSnapshot: aSnapshot priors: priors [
	
	fileReference writeStreamDo: [ :stream |
		STON put: aSnapshot onStreamPretty: stream ].
	
	soleSnapshot := aSnapshot.
	
	^ self soleNode
]

{ #category : #accessing }
FiFlatStore >> fileReference [
	^ fileReference
]

{ #category : #accessing }
FiFlatStore >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #accessing }
FiFlatStore >> headHistoryNode [

	^ self soleNode
]

{ #category : #accessing }
FiFlatStore >> historyNodes [

	^ { self soleNode }
]

{ #category : #accessing }
FiFlatStore >> name [

	^ name ifNil: [ name := self hash printStringHex ]
]

{ #category : #accessing }
FiFlatStore >> name: aString [

	name := aString
]

{ #category : #printing }
FiFlatStore >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: self name;
		nextPut: $).
]

{ #category : #refreshing }
FiFlatStore >> refresh [

	soleSnapshot :=
		fileReference readStreamDo: [ :stream |
			STON fromStream: stream ].

]

{ #category : #accessing }
FiFlatStore >> soleNode [

	^ (FiSnapshotHistoryNode builder
		origin: (FiSingleOrigin withReference: self soleSnapshot hash printStringHex);
		snapshot: self soleSnapshot;
		priors: FiSet new;
		new).
]

{ #category : #accessing }
FiFlatStore >> soleSnapshot [

	^ soleSnapshot
]
