Class {
	#name : #FiAbstractStore,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'cachedHistoryNodes',
		'cachedHeadHistoryNodes'
	],
	#category : #'FicusStore-Stores'
}

{ #category : #accessing }
FiAbstractStore >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
FiAbstractStore >> headHistoryNode [

	^ cachedHeadHistoryNodes ifNil: [ 
		self refresh. 
		cachedHeadHistoryNodes ]
]

{ #category : #accessing }
FiAbstractStore >> historyNodes [

	^ cachedHistoryNodes ifNil: [ 
		self refresh. 
		cachedHistoryNodes ]
]

{ #category : #refreshing }
FiAbstractStore >> invalidateCaches [
	
	cachedHeadHistoryNodes := nil.
	cachedHistoryNodes := nil.
	
	self flag: #fix.
]

{ #category : #refreshing }
FiAbstractStore >> refresh [
	"Refresh the history nodes and the head."
	
	^ self subclassResponsibility
]
