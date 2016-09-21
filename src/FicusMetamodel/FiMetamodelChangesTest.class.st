Class {
	#name : #FiMetamodelChangesTest,
	#superclass : #TestCase,
	#category : #'FicusMetamodel-Tests'
}

{ #category : #tests }
FiMetamodelChangesTest >> testEditInRenamedPackage [

	| change destination destinationPlusChange |
	change := RFiFragileBaseClassProblemResources2 new ficusEnvironment 
		changeFrom: RFiFragileBaseClassProblemResources1 new ficusEnvironment.
		
	destination := RFiLoggersRenamedResources new ficusEnvironment.
	destinationPlusChange := destination resultOf: change edit.

	self assert: (destinationPlusChange changeFrom: destination) equals: change
]
