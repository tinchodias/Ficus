Class {
	#name : #FiVariableBinding,
	#superclass : #FiDependencyInterpretation,
	#instVars : [
		'target'
	],
	#category : #'FicusImpact-Interpretations'
}

{ #category : #'instance creation' }
FiVariableBinding class >> undeclared [

	self flag: #todo. "fix"
	
	^ self new
]

{ #category : #printing }
FiVariableBinding >> printOn: aStream [
	
	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: target asString;
		nextPut: $).
]

{ #category : #accessing }
FiVariableBinding >> target [
	
	^ target
]
