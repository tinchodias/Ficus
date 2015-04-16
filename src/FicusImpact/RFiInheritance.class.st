Class {
	#name : #RFiInheritance,
	#superclass : #RFiDependency,
	#instVars : [
		'target'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #'instance creation' }
RFiInheritance class >> notFound [

	self flag: #todo. "fix"
	
	^ self new
]

{ #category : #printing }
RFiInheritance >> printOn: aStream [
	
	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: target asString;
		nextPut: $).
]

{ #category : #accessing }
RFiInheritance >> target [
	
	^ target
]

{ #category : #accessing }
RFiInheritance >> targets [
	
	^ { target }
]
