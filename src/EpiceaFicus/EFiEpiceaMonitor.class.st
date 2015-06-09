Class {
	#name : #EFiEpiceaMonitor,
	#superclass : #EFiMonitor,
	#instVars : [
		'workingCopyRegistry'
	],
	#category : #'EpiceaFicus-Monitors'
}

{ #category : #'as yet unclassified' }
EFiEpiceaMonitor class >> newMemoryStore [
	
	| store |
	store := FiMemoryStore new.
	store name: 'Epicea-Events'.

	self flag: #todo. "?"
	store 
		commitSnapshot: FiSet new "FiSession newCurrent"
		priors: FiSet new.

	^ store
]

{ #category : #enabling }
EFiEpiceaMonitor >> disable [

	workingCopyRegistry workingCopies do: [ :each | each announcer unsubscribe: self ]
]

{ #category : #enabling }
EFiEpiceaMonitor >> enable [

	{	FiWorkingCopyEdited -> #metamodelEdited:.
		FiWorkingCopySettedSnapshot -> #metamodelSettedSnapshot:.
	} do: [ :pair |
		workingCopyRegistry workingCopies do: [ :each | 
			each announcer weak
				on: pair key 
				send: pair value 
				to: self] ].
]

{ #category : #enabling }
EFiEpiceaMonitor >> isEnabled [

	^ metamodelAnnouncer hasSubscriber: self
]

{ #category : #'announcement handling' }
EFiEpiceaMonitor >> metamodelEdited: anAnnouncement [

	outputWorkingCopy 
		snapshot: anAnnouncement; 
		commit: 'epicea'
]

{ #category : #'announcement handling' }
EFiEpiceaMonitor >> metamodelSettedSnapshot: anAnnouncement [

	1halt.
]

{ #category : #accessing }
EFiEpiceaMonitor >> workingCopyRegistry [

	^ workingCopyRegistry
]

{ #category : #accessing }
EFiEpiceaMonitor >> workingCopyRegistry: aWorkingCopyRegistry [

	workingCopyRegistry := aWorkingCopyRegistry
]
