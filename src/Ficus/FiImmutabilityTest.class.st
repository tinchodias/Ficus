Class {
	#name : #FiImmutabilityTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests'
}

{ #category : #'as yet unclassified' }
FiImmutabilityTest class >> candidatesForRemoval [

	^ FiShot withAllSubclasses collect: [ :aClass |
		aClass -> (aClass allInstVarNames flatCollect: [ :instanceVariableName |
			((aClass whichSelectorsStoreInto: instanceVariableName) reject: [ :selector | selector beginsWith: #init ]) ]) ]
]

{ #category : #'as yet unclassified' }
FiImmutabilityTest class >> removeAllCandidates [
	"
	self removeAllCandidates
	"

	self candidatesForRemoval do: [ :assoc |
		assoc value do: [ :selector |
			assoc key removeSelector: selector ] ]
]

{ #category : #'as yet unclassified' }
FiImmutabilityTest >> assertHasNotSetters: shotClass [

	shotClass allInstVarNames do: [ :instanceVariableName |
		self assertHasNotSetters: shotClass instanceVariableName: instanceVariableName ]
]

{ #category : #'as yet unclassified' }
FiImmutabilityTest >> assertHasNotSetters: shotClass instanceVariableName: instanceVariableName [
	"Thanks to Clara for her help"

	| setters |
	setters := ((shotClass whichSelectorsStoreInto: instanceVariableName) 
		reject: [ :selector | (selector beginsWith: #init) or: [ self falsePositiveSetters includes: selector ] ]).

	self assert: setters isEmpty description: 'Setters found in: ', shotClass name, ' selectors: ', setters asString
]

{ #category : #'as yet unclassified' }
FiImmutabilityTest >> falsePositiveSetters [
	
	^ #( #tag: #hash )
]

{ #category : #'as yet unclassified' }
FiImmutabilityTest >> testImmutable [

	FiShot withAllSubclasses do: [ :shotClass |
		self assertHasNotSetters: shotClass ]
]

{ #category : #'as yet unclassified' }
FiImmutabilityTest >> testMethod [

	self assertHasNotSetters: FiMethod
]
