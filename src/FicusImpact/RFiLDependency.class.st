Class {
	#name : #RFiLDependency,
	#superclass : #Object,
	#instVars : [
		'source',
		'target'
	],
	#category : #'FicusImpact-LDependency'
}

{ #category : #'instance creation' }
RFiLDependency class >> from: sourceEntity to: targetEntity [
	
	^ self new
		initializeFromSource: sourceEntity
		target: targetEntity;
		yourself.
]

{ #category : #initialization }
RFiLDependency >> initializeFromSource: sourceEntity target: targetEntity [

	self initialize.
	
	source := sourceEntity.
	target := targetEntity.
]

{ #category : #printing }
RFiLDependency >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: source shortPrintString;
		nextPutAll: '->';
		nextPutAll: target shortPrintString;
		nextPut: $).
]

{ #category : #accessing }
RFiLDependency >> source [

	^ source
]

{ #category : #accessing }
RFiLDependency >> target [

	^ target
]
