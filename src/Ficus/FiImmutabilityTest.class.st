Class {
	#name : #FiImmutabilityTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #utilities }
FiImmutabilityTest class >> candidatesForRemoval [

	^ FiShot withAllSubclasses collect: [ :aClass |
		aClass -> (aClass allInstVarNames flatCollect: [ :instanceVariableName |
			((aClass whichSelectorsStoreInto: instanceVariableName) reject: [ :selector | selector beginsWith: #init ]) ]) ]
]

{ #category : #utilities }
FiImmutabilityTest class >> removeAllCandidates [
	"
	self removeAllCandidates
	"

	self candidatesForRemoval do: [ :assoc |
		assoc value do: [ :selector |
			assoc key removeSelector: selector ] ]
]

{ #category : #running }
FiImmutabilityTest >> assertHasNotSetters: shotClass [

	(shotClass allInstVarNames copyWithoutAll: shotClass excludedInstanceVariableNamesForSteps) 
		do: [ :instanceVariableName |
			self assertHasNotSetters: shotClass instanceVariableName: instanceVariableName ]
]

{ #category : #running }
FiImmutabilityTest >> assertHasNotSetters: shotClass instanceVariableName: instanceVariableName [
	"Thanks to Clara for her help"

	| setters |
	setters := 
		(shotClass whichSelectorsStoreInto: instanceVariableName) 
			reject: [ :selector | selector beginsWith: #init ].

	self 
		assert: setters isEmpty 
		description: 'Setters found in: ', shotClass name, ' instanceVariableName: ', instanceVariableName, ' selectors: ', setters asString
]

{ #category : #tests }
FiImmutabilityTest >> testImmutable [

	FiShot withAllSubclasses do: [ :shotClass |
		self assertHasNotSetters: shotClass ]
]
