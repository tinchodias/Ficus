Class {
	#name : #EFiCodeMonitor,
	#superclass : #EFiMonitor,
	#instVars : [
		'systemAnnouncer'
	],
	#category : #'EpiceaFicus-Monitors'
}

{ #category : #example }
EFiCodeMonitor class >> example [
"
Sentences used in development.
"

EFiCodeMonitor reset.
EFiCodeMonitor current enable.
EFiCodeMonitor current disable.
EFiCodeMonitor current open.
EFiCodeMonitor current resyncPackageNamed: #EpiceaFicus.
Smalltalk garbageCollect.
EFiCodeMonitor current workingCopy store historyNodes.

EFiInspector inspect: 
	(FiChange fromAll: 
		(EFiCodeMonitor current workingCopy store historyNodes 
			flatCollect: [ :each | each deltas collect: #value ])).

"Examples"
Object subclass: #Ah5
	instanceVariableNames: 'a b'
	classVariableNames: ''
	category: 'Ah'.
#Ah5 asClass compile: 'm1 ^42' classified: #accessing. 
]

{ #category : #'instance creation' }
EFiCodeMonitor class >> newMemoryStore [
	
	| store packages |
	store := FiMemoryStore new.
	store name: 'Pharo-Code'.

	packages := MCWorkingCopy allManagers collect: [ :each | each ficusPackage ].

	store 
		commitSnapshot: (FiEnvironment withAll: packages)
		priors: FiSet new.

	^ store
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> behaviorAdded: aClassAddedAnnoucement [

	(aClassAddedAnnoucement classAdded isTrait)
		ifTrue:  [ self traitAdded: aClassAddedAnnoucement ]
		ifFalse: [ self classAdded: aClassAddedAnnoucement ]
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> behaviorModified: aClassModifiedClassDefinitionAnnouncement [

	(aClassModifiedClassDefinitionAnnouncement classAffected isTrait)
		ifTrue:  [ self traitModified: aClassModifiedClassDefinitionAnnouncement ]
		ifFalse: [ self classModified: aClassModifiedClassDefinitionAnnouncement ]
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> behaviorRemoved: aClassRemovedAnnoucement [

	(aClassRemovedAnnoucement classAffected isTrait)
		ifTrue:  [ self traitRemoved: aClassRemovedAnnoucement ]
		ifFalse: [ self classRemoved: aClassRemovedAnnoucement ]
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> classAdded: aClassAddedAnnoucement [

	self commitEdit: 
		(self editBuilder classCreation: aClassAddedAnnoucement classAdded theNonMetaClass asEpiceaRingDefinition)
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> classCommented: anAnnouncement [

	self commitEdit: 
		(self editBuilder 
			behaviorCommentUpdateIn: anAnnouncement classCommented asEpiceaRingDefinition
			to: anAnnouncement newComment asString)
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> classModified: aClassModifiedAnnouncement [

	self commitEdit: 
		(self editBuilder
			classUpdateFrom: aClassModifiedAnnouncement oldClassDefinition asEpiceaRingDefinition
			to: aClassModifiedAnnouncement newClassDefinition asEpiceaRingDefinition)
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> classRecategorized: anAnnouncement [

	anAnnouncement newCategory = anAnnouncement oldCategory
		ifTrue: [ ^ self ].
		1halt.
"	oldPackageName := RPackageOrganizer default 
		packageMatchingExtensionName: anAnnouncement oldCategory.
	newPackageName := RPackageOrganizer default 
		packageMatchingExtensionName: anAnnouncement newCategory.
"
	self commitEdit: ([
		(self editBuilder 
			behaviorCategoryUpdateIn: anAnnouncement classAffected asEpiceaRingDefinition
			to: anAnnouncement newCategory) ] 
	on: StepNotFound do: [ :e |
		(self editBuilder 
			behaviorCategoryUpdateIn: 
				(anAnnouncement classAffected asEpiceaRingDefinition
					package: (RPackageOrganizer default 
						packageMatchingExtensionName: anAnnouncement oldCategory);
					yourself)
			to: anAnnouncement newCategory)

	"	self resyncPackageNamed: anAnnouncement classAffected asEpiceaRingDefinition package name."
		 ])
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> classRemoved: aClassRemovedAnnoucement [

	self commitEdit: 
		(self editBuilder
			classRemoval: aClassRemovedAnnoucement classRemoved)
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> classRenamed: aClassRenamed [

	self notYetImplemented 
	"| aChange |	
	aChange := EpBehaviorNameChange
		oldName: aClassRenamed oldName
		newName: aClassRenamed  newName
		class: aClassRenamed classAffected.
	self commitEdit: aChange."
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> classRepackaged: anAnnouncement [

"	anAnnouncement newPackage = anAnnouncement oldPackage
		ifTrue: [ ^ self ].

	self commitEdit:
		(self editBuilder 
			behaviorPackageUpdateIn: anAnnouncement classRepackaged asEpiceaRingDefinition
			from: anAnnouncement oldPackage
			to: anAnnouncement newPackage)"
]

{ #category : #private }
EFiCodeMonitor >> commitEdit: anEdit [ 

	outputWorkingCopy applyEdit: anEdit
]

{ #category : #enabling }
EFiCodeMonitor >> disable [
	
	systemAnnouncer unsubscribe: self
]

{ #category : #private }
EFiCodeMonitor >> editBuilder [
	
	^ EFiEditBuilder new
]

{ #category : #enabling }
EFiCodeMonitor >> enable [

	{	ClassAdded -> #behaviorAdded:.
		ClassRemoved -> #behaviorRemoved:.
		ClassModifiedClassDefinition -> #behaviorModified:.
		ClassRecategorized -> #classRecategorized:.
		ClassRenamed -> #classRenamed:.
		ClassCommented -> #classCommented:.
		ClassRepackaged ->  #classRepackaged:.
		MethodAdded -> #methodAdded:.
		MethodRemoved -> #methodRemoved:.
		MethodModified -> #methodModified:.
		MethodRecategorized -> #methodRecategorized:.
"		SnapshotDone -> #snapshotDone:. 
		EpMonticelloVersionSave -> #addEvent:.
		EpCodeChange -> #addEvent:.
		EpEventStart -> #eventStarted:.
		EpEventEnd -> #eventEnded:
"	} do: [ :pair |
		systemAnnouncer weak
			on: pair key 
			send: pair value 
			to: self ].

]

{ #category : #enabling }
EFiCodeMonitor >> isEnabled [

	^ systemAnnouncer hasSubscriber: self
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> methodAdded: aMethodAddedAnnoucement [

	self commitEdit: 
		(self editBuilder
			methodCreation: aMethodAddedAnnoucement methodAffected asEpiceaRingDefinition)
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> methodModified: aMethodModified [

	(aMethodModified oldMethod sourceCode = aMethodModified newMethod sourceCode 
		and: [ aMethodModified oldProtocol = aMethodModified newProtocol ])
		ifTrue: [ ^self ].
		
	self commitEdit: 
		(self editBuilder
			methodUpdateFrom: aMethodModified oldMethod asEpiceaRingDefinition
			to: aMethodModified newMethod asEpiceaRingDefinition)
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> methodRecategorized: aMethodRecategorized [ 

	| oldMethod newMethod |
	"Workaround: In Pharo3, when a trait is removed from the trait composition, then this announcement is wrongly announced."

	aMethodRecategorized methodRecategorized ifNil: [ ^ self ].

	oldMethod := aMethodRecategorized methodRecategorized asEpiceaRingDefinition
		protocol: aMethodRecategorized oldProtocol;
		yourself.
	newMethod := aMethodRecategorized methodRecategorized asEpiceaRingDefinition
		protocol: aMethodRecategorized newProtocol;
		yourself.
	 
	self commitEdit:
		(self editBuilder methodUpdateFrom: oldMethod to: newMethod)
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> methodRemoved: aMethodRemovedAnnoucement [

	self commitEdit: 
		(self editBuilder
			methodRemoval: aMethodRemovedAnnoucement methodAffected asEpiceaRingDefinition)
]

{ #category : #syncing }
EFiCodeMonitor >> resyncPackageNamed: aPackageName [

	| edit currentWorkingCopy |
	currentWorkingCopy := MCWorkingCopy allManagers detect: [ :each | each packageName = aPackageName ].

	edit := 
		FiSubEdit 
			path: { #packages. aPackageName } asFiPath
			equal: currentWorkingCopy ficusPackage.

	outputWorkingCopy snapshot: (outputWorkingCopy snapshot resultOf: edit).
	outputWorkingCopy commit: ''.
]

{ #category : #accessing }
EFiCodeMonitor >> systemAnnouncer [

	^ systemAnnouncer
]

{ #category : #accessing }
EFiCodeMonitor >> systemAnnouncer: aSystemAnnouncer [

	systemAnnouncer := aSystemAnnouncer.
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> traitAdded: aClassAddedAnnoucement [

	self commitEdit: 
		(self editBuilder traitCreation: aClassAddedAnnoucement classAdded)
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> traitModified: aClassModifiedClassDefinitionAnnouncement [

	self commitEdit: 
		(self editBuilder
			traitUpdateFrom: aClassModifiedClassDefinitionAnnouncement oldClassDefinition
			to: aClassModifiedClassDefinitionAnnouncement newClassDefinition)
]

{ #category : #'announcement handling' }
EFiCodeMonitor >> traitRemoved: aClassRemovedAnnoucement [

	self commitEdit: 
		(self editBuilder
			traitRemoval: aClassRemovedAnnoucement classRemoved)
]
