Class {
	#name : #FiInheritance,
	#superclass : #FiDependency,
	#instVars : [
		'target'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #'instance creation' }
FiInheritance class >> notFound [

	self flag: #todo. "fix"
	
	^ self new
]

{ #category : #printing }
FiInheritance >> printOn: aStream [
	
	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: target asString;
		nextPut: $).
]

{ #category : #accessing }
FiInheritance >> target [
	
	^ target
]

{ #category : #accessing }
FiInheritance >> targets [
	
	^ { target }
]
