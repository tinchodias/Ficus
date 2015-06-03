"
I am polymorphic with RPackage, fetching everything needed from a Ficus environment.
"
Class {
	#name : #RFiPackage,
	#superclass : #RFiObject,
	#instVars : [
		'environment',
		'definedClasses',
		'ficusPackage',
		'definedTraits'
	],
	#category : #'FicusRing-Core'
}

{ #category : #'instance creation' }
RFiPackage class >> environment: aRFiEnvironment ficusPackage: aFiPackage [

	^ self basicNew
		initializeWithEnvironment: aRFiEnvironment 
		ficusPackage: aFiPackage;
		yourself
]

{ #category : #polymorphism }
RFiPackage >> asRingDefinition [

	^ RGPackage named: self name asSymbol
]

{ #category : #polymorphism }
RFiPackage >> definedClasses [

	^ definedClasses ifNil: [ 
		definedClasses := ficusPackage classes 
			collect: [ :classShot | environment ringClassFor: classShot ] ]
]

{ #category : #accessing }
RFiPackage >> definedMethods [

	^ Array streamContents: [ :stream |
		self definedClasses do: [ :each | 
			stream 
				nextPutAll: each localMethods;
				nextPutAll: each classSide localMethods ].

		stream nextPutAll: self extensionMethods 
		]
]

{ #category : #polymorphism }
RFiPackage >> definedTraits [

	^ definedTraits ifNil: [ 
		definedTraits := ficusPackage traits 
			collect: [ :traitShot | environment ringTraitFor: traitShot ] ]
]

{ #category : #'as yet unclassified' }
RFiPackage >> environment [

	^ environment
]

{ #category : #accessing }
RFiPackage >> extensionMethods [

	self flag: #todo. "delegate this instantiation to behaviors".
	
	^ ficusPackage extensionMethods flatCollect: [ :ficusExtensionMethods |
		| ringClass |
		ringClass := environment classNamed: ficusExtensionMethods hostName.

		ficusExtensionMethods isMetaSide ifTrue: [ 
			ringClass := ringClass classSide ].

		ficusExtensionMethods methods collect: [ :ficusMethod |
			 RFiMethod
				methodClass: ringClass
				ficusMethod: ficusMethod ] ]
]

{ #category : #testing }
RFiPackage >> includesClass: aRFiClass [ 

	^ self definedClasses includes: aRFiClass
]

{ #category : #initialization }
RFiPackage >> initializeWithEnvironment: aRFiEnvironment ficusPackage: aFiPackage [

	self initialize.
	
	environment := aRFiEnvironment.
	ficusPackage := aFiPackage.
]

{ #category : #polymorphism }
RFiPackage >> name [

	^ ficusPackage name
]

{ #category : #printing }
RFiPackage >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $).
	
]
