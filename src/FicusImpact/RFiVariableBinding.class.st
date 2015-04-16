Class {
	#name : #RFiVariableBinding,
	#superclass : #RFiDependency,
	#instVars : [
		'target'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #'instance creation' }
RFiVariableBinding class >> undeclared [

	self flag: #todo. "fix"
	
	^ self new
]

{ #category : #printing }
RFiVariableBinding >> printOn: aStream [
	
	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: target asString;
		nextPut: $).
]

{ #category : #accessing }
RFiVariableBinding >> target [
	
	^ target
]

{ #category : #accessing }
RFiVariableBinding >> targets [
	
	^ target 
		ifNil: [ #() ]
		ifNotNil: [ {target} ]
]
