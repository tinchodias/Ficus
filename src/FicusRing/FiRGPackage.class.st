"
I am polymorphic with RPackage, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGPackage,
	#superclass : #Object,
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

{ #category : #accessing }
FiRGPackage >> environment: aFiRGEnvironment [ 

	environment := aFiRGEnvironment
]

{ #category : #polymorphism }
FiRGPackage >> name [

	^ packageShot theName
]

{ #category : #accessing }
FiRGPackage >> packageShot: aFiPackage [ 

	packageShot := aFiPackage
]
