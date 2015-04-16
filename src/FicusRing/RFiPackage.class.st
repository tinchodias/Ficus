"
I am polymorphic with RPackage, fetching everything needed from a Ficus environment.
"
Class {
	#name : #RFiPackage,
	#superclass : #RFiObject,
	#instVars : [
		'environment',
		'packageShot',
		'definedClasses'
	],
	#category : #'FicusRing-Core'
}

{ #category : #polymorphism }
RFiPackage >> asRingDefinition [

	^ RGPackage named: self name asSymbol
]

{ #category : #polymorphism }
RFiPackage >> definedClasses [

	^ definedClasses ifNil: [ 
		definedClasses := packageShot classes 
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

{ #category : #accessing }
RFiPackage >> environment: aFiRGEnvironment [ 

	environment := aFiRGEnvironment
]

{ #category : #accessing }
RFiPackage >> extensionMethods [

	self flag: #todo. "delegate this instantiation to behaviors".
	
	^ packageShot extensionMethods flatCollect: [ :ficusExtensionMethods |
		| ringClass |
		ringClass := environment classNamed: ficusExtensionMethods hostName.

		ficusExtensionMethods isMetaSide ifTrue: [ 
			ringClass := ringClass classSide ].

		ficusExtensionMethods methods collect: [ :ficusMethod |
			 RFiMethod new 
				methodClass: ringClass;
				methodShot: ficusMethod;
				yourself ] ]
]

{ #category : #testing }
RFiPackage >> includesClass: aFiRGClass [ 

	^ self definedClasses includes: aFiRGClass
]

{ #category : #polymorphism }
RFiPackage >> name [

	^ packageShot name
]

{ #category : #accessing }
RFiPackage >> packageShot: aFiPackage [ 

	packageShot := aFiPackage
]

{ #category : #printing }
RFiPackage >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $).
	
]
