"
I am an abstract store. See my concrete subclasses.
"
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
FiAbstractStore >> commitEdit: anEdit prior: priorHistoryNode [

	^ self 
		commitSnapshot: (self headSnapshot resultOf: anEdit) 
		priors: { priorHistoryNode } asFiSet
]

{ #category : #accessing }
FiAbstractStore >> commitSnapshot: aSnapshot priors: priors [
	"Perform a commit"
	
	^ self subclassResponsibility
]

{ #category : #refreshing }
FiAbstractStore >> ensureReady [

	self isReady ifFalse: [ self refresh ].
]

{ #category : #accessing }
FiAbstractStore >> headHistoryNode [

	^ self historyNodes
		ifEmpty: [ nil ] 
		ifNotEmpty: [ :nodes | nodes last ].
]

{ #category : #accessing }
FiAbstractStore >> headSnapshot [

	^ self headHistoryNode snapshot 
]

{ #category : #accessing }
FiAbstractStore >> historyNodes [

	^ self subclassResponsibility 
]

{ #category : #testing }
FiAbstractStore >> isReady [

	^ true
]

{ #category : #'working copies' }
FiAbstractStore >> newWorkingCopy [

	^ FiWorkingCopy new
		name: self name;
		snapshot: self headSnapshot;
		priors: {self headHistoryNode} asFiSet;
		store: self;
		yourself.

]

{ #category : #refreshing }
FiAbstractStore >> refresh [
	"Refresh the history nodes and the head."
	
	^ self subclassResponsibility
]
