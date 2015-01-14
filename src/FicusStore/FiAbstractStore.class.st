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

{ #category : #refreshing }
FiAbstractStore >> refresh [
	"Refresh the history nodes and the head."
	
	^ self subclassResponsibility
]
