Class {
	#name : #FiEnvironmentSpot,
	#superclass : #FiMetamodelSpot,
	#category : #'FicusMetamodel-Spots'
}

{ #category : #'as yet unclassified' }
FiEnvironmentSpot class >> canInstantiateSpotFrom: steps ifTrue: aBlockClosure [

	^ steps = #(packages)
]

{ #category : #printing }
FiEnvironmentSpot >> shortPrintString [

	^ 'environment'
]
