Class {
	#name : #FiAbstractStore,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'FicusStore-Stores'
}

{ #category : #accessing }
FiAbstractStore >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
FiAbstractStore >> headHistoryNode [

	^ self subclassResponsibility 
]

{ #category : #accessing }
FiAbstractStore >> historyNodes [

	^ self subclassResponsibility 
]

{ #category : #'working copies' }
FiAbstractStore >> newWorkingCopy [

	^ FiWorkingCopy new
		name: self name;
		snapshot: self headHistoryNode snapshot;
		store: self;
		yourself.

]

{ #category : #refreshing }
FiAbstractStore >> refresh [
	"Refresh the history nodes and the head."
	
	^ self subclassResponsibility
]
