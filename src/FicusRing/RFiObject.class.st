"
I am the abstract superclass of classes that are polymorphic with metamodel entities, fetching everything needed from a Ficus environment.
"
Class {
	#name : #RFiObject,
	#superclass : #Object,
	#category : #'FicusRing-Core'
}

{ #category : #'as yet unclassified' }
RFiObject >> environment [

	^ self subclassResponsibility
]

{ #category : #accessing }
RFiObject >> ficusObject [

	^ self ficusPathFromEnvironment resolvedOn: self environment ficusPackages 
]

{ #category : #accessing }
RFiObject >> ficusPathFromEnvironment [

	^ self subclassResponsibility
]

{ #category : #printing }
RFiObject >> shortPrintString [

	^ self name
]

{ #category : #'as yet unclassified' }
RFiObject >> systemNavigation [

	^ SystemNavigation new 
		environment: self environment;
		yourself
]
