Class {
	#name : #FiMetamodelSpot,
	#superclass : #FiSpot,
	#instVars : [
		'packageName'
	],
	#category : #'FicusMetamodel-Spots'
}

{ #category : #'as yet unclassified' }
FiMetamodelSpot class >> spotFromPath: aPath [ 

	| steps |
	steps := aPath steps.
	
	^ self subclassesDo: [ :aSpotSubclass |
		aSpotSubclass 
			canInstantiateSpotFrom: steps 
			ifTrue: [ :spot | ^ spot ] ]
]

{ #category : #comparing }
FiMetamodelSpot >> = other [

	^ self class = other class and: [ 
		self packageName = other packageName ]
]

{ #category : #'as yet unclassified' }
FiMetamodelSpot >> asShortPrintStrings [

	^ { self shortPrintString }
]

{ #category : #comparing }
FiMetamodelSpot >> hash [

	^ self class hash bitXor: self packageName hash
]

{ #category : #accessing }
FiMetamodelSpot >> packageName [

	^ packageName
]

{ #category : #printing }
FiMetamodelSpot >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self shortPrintString;
		nextPut: $).
]

{ #category : #'as yet unclassified' }
FiMetamodelSpot >> shortPrintString [

	^ self subclassResponsability
]
