Class {
	#name : #FiEmptyMetacelloImporterTest,
	#superclass : #FiMetacelloEnvironmentImporterTest,
	#category : #'FicusMonticello-Tests'
}

{ #category : #tests }
FiEmptyMetacelloImporterTest >> import [

	^ self importVersion: (ConfigurationOfEmpty project version: '1.0').
]

{ #category : #tests }
FiEmptyMetacelloImporterTest >> testEmptyConfigurationReturnsEmptyEnviroment [

	| result |
	result := self import.
	self assert: result isEmpty.
	
]
