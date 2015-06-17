"
I am the abstract superclass of classes that are polymorphic with metamodel entities, fetching everything needed from a Ficus environment.
"
Class {
	#name : #RFiObject,
	#superclass : #Object,
	#category : #'FicusRing-Core'
}

{ #category : #accessing }
RFiObject >> asMetamodelSpot [

	^ self subclassResponsibility
]

{ #category : #polymorphism }
RFiObject >> environment [

	^ self subclassResponsibility
]

{ #category : #accessing }
RFiObject >> ficusObject [

	^ self asMetamodelSpot resolvedOn: self environment ficusEnvironment
]

{ #category : #polymorphism }
RFiObject >> properties [

	^ nil
]

{ #category : #caching }
RFiObject >> resetCaches [
	
	self class allInstVarNames 
		select: [ :each | each beginsWith: 'cached' ] 
		thenDo: [ :each | self instVarNamed: each put: nil ]
]

{ #category : #printing }
RFiObject >> shortPrintString [

	^ self name
]

{ #category : #polymorphism }
RFiObject >> systemNavigation [

	^ SystemNavigation new 
		environment: self environment;
		yourself
]
