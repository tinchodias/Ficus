Class {
	#name : #EFiRefactoringMonitor,
	#superclass : #EFiMonitor,
	#instVars : [
		'announcer'
	],
	#category : #'EpiceaFicus-Monitors'
}

{ #category : #enabling }
EFiRefactoringMonitor >> disable [
	"Disable monitoring"

	self isEnabled ifFalse: [ ^ self ].

	announcer unsubscribe: self.

]

{ #category : #enabling }
EFiRefactoringMonitor >> enable [

	{
"		SnapshotDone -> #snapshotDone:. 
		EpMonticelloVersionSave -> #addEvent:.
		EpEventStart -> #eventStarted:.
		EpEventEnd -> #eventEnded:
"	} do: [ :pair |
		announcer weak
			on: pair key 
			send: pair value 
			to: self ].

]

{ #category : #enabling }
EFiRefactoringMonitor >> isEnabled [

	^ announcer hasSubscriber: self
]
