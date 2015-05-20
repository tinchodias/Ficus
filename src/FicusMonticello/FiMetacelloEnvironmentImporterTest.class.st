"
Class kinds / formats not in ring.
Configurations with multiple packages.
Configurations depending on other configurations.
"
Class {
	#name : #FiMetacelloEnvironmentImporterTest,
	#superclass : #TestCase,
	#category : #'FicusMonticello-Tests'
}

{ #category : #tests }
FiMetacelloEnvironmentImporterTest >> import [

	self subclassResponsibility
]

{ #category : #tests }
FiMetacelloEnvironmentImporterTest >> importVersion: aVersion [

	^ MetacelloEnvironmentImporter new import: aVersion.
]
