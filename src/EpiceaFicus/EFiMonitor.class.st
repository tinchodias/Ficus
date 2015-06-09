Class {
	#name : #EFiMonitor,
	#superclass : #Object,
	#instVars : [
		'outputWorkingCopy'
	],
	#classInstVars : [
		'current'
	],
	#category : #'EpiceaFicus-Monitors'
}

{ #category : #accessing }
EFiMonitor class >> current [

	current ifNil: [
		current := self new ].
	
	^ current
]

{ #category : #accessing }
EFiMonitor class >> current: aMonitor [

	current := aMonitor
]

{ #category : #accessing }
EFiMonitor class >> reset [
	"
	self reset
	"

	self current disable.
	self current: nil
]

{ #category : #enabling }
EFiMonitor >> disable [
	"Disable monitoring"

	^ self subclassResponsibility
]

{ #category : #enabling }
EFiMonitor >> enable [
	"Enable monitoring"
	
	^ self subclassResponsibility
]

{ #category : #enabling }
EFiMonitor >> isEnabled [

	^ self subclassResponsibility
]

{ #category : #ui }
EFiMonitor >> open [
	
	FiWorkingCopyRegistryBrowser openWith: 
		(FiWorkingCopyRegistry new 
			addWorkingCopy: outputWorkingCopy; 
			yourself)
]

{ #category : #accessing }
EFiMonitor >> outputWorkingCopy [

	^ outputWorkingCopy
]

{ #category : #accessing }
EFiMonitor >> outputWorkingCopy: aWorkingCopy [

	outputWorkingCopy := aWorkingCopy
]
