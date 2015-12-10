Class {
	#name : #FiMethodOwner,
	#superclass : #FiDependency,
	#instVars : [
		'target'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #'instance creation' }
FiMethodOwner class >> notFound [

	self flag: #todo. "fix"
	
	^ self new
]

{ #category : #printing }
FiMethodOwner >> printOn: aStream [
	
	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: target asString;
		nextPut: $).
]

{ #category : #accessing }
FiMethodOwner >> target [
	
	^ target
]

{ #category : #accessing }
FiMethodOwner >> targets [
	
	^ { target }
]
