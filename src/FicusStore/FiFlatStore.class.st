"
I am a store that persists it's sole snapshot in a file system. I don't keep track of history.
"
Class {
	#name : #FiFlatStore,
	#superclass : #FiAbstractStore,
	#instVars : [
		'fileReference',
		'name',
		'soleNode'
	],
	#category : #'FicusStore-Stores'
}

{ #category : #accessing }
FiFlatStore >> commitSnapshot: aSnapshot priors: priors [
	
	fileReference writeStreamDo: [ :stream |
		STON put: aSnapshot onStreamPretty: stream ].
	
	self refreshSoleNodeWith: aSnapshot.
	
	^ soleNode
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

	^ soleNode
]

{ #category : #accessing }
FiFlatStore >> historyNodes [

	^ { soleNode }
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

	self refreshSoleNodeWith: 
		(fileReference readStreamDo: [ :stream |
			STON fromStream: stream ]).

]

{ #category : #accessing }
FiFlatStore >> refreshSoleNodeWith: aSnapshot [

	soleNode := (FiSnapshotHistoryNode builder
		origin: (FiSingleOrigin withReference: fileReference basename);
		snapshot: aSnapshot;
		priors: FiSet new;
		new).
]
