"
I am polymorphic with RPackage, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGPackage,
	#superclass : #FiRGObject,
	#instVars : [
		'environment',
		'packageShot',
		'definedClasses'
	],
	#category : #'FicusRing-Core'
}

{ #category : #polymorphism }
FiRGPackage >> definedClasses [

	^ definedClasses ifNil: [ 
		definedClasses := packageShot classes 
			collect: [ :classShot | environment ringClassFor: classShot ] ]
]

{ #category : #'as yet unclassified' }
FiRGPackage >> definedMethods [
	
	^ (self definedClasses flatCollect: [ :each | 
		each localMethods, each classSide localMethods ]) 
			union: self extensionMethods
]

{ #category : #accessing }
FiRGPackage >> environment: aFiRGEnvironment [ 

	environment := aFiRGEnvironment
]

{ #category : #'as yet unclassified' }
FiRGPackage >> extensionMethods [

	^ packageShot extensionMethods flatCollect: [ :ficusExtensionMethods |
		| ringClass |
		ringClass := environment classNamed: ficusExtensionMethods hostName.

		ficusExtensionMethods isMetaSide ifTrue: [ 
			ringClass := ringClass classSide ].

		ficusExtensionMethods methods collect: [ :ficusMethod |
			 FiRGMethod new 
				methodClass: ringClass;
				methodShot: ficusMethod;
				yourself ] ]
]

{ #category : #polymorphism }
FiRGPackage >> name [

	^ packageShot theName
]

{ #category : #accessing }
FiRGPackage >> packageShot: aFiPackage [ 

	packageShot := aFiPackage
]

{ #category : #printing }
FiRGPackage >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $).
	
]
