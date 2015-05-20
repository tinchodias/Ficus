Class {
	#name : #FiPackageSpot,
	#superclass : #FiMetamodelSpot,
	#category : #'FicusMetamodel-Spots'
}

{ #category : #'as yet unclassified' }
FiPackageSpot class >> canInstantiateSpotFrom: steps ifTrue: aBlockClosure [ 
	
	steps size < 2 ifTrue: [ ^ false ].
	steps size > 3 ifTrue: [ ^ false ].
	
	steps size = 2 ifTrue: [ 
		aBlockClosure value: (FiPackageSpot named: steps second).
		^ true ].
	
	^ self notYetImplemented 
]

{ #category : #'instance creation' }
FiPackageSpot class >> named: aPackageName [

	^ self basicNew
		initializeWithName: aPackageName;
		yourself
]

{ #category : #converting }
FiPackageSpot >> asPathOn: anObject [

	^ anObject pathOfPackageSpot: self
]

{ #category : #initialization }
FiPackageSpot >> initializeWithName: aPackageName [ 

	self initialize.
	
	packageName := aPackageName.
	
]

{ #category : #printing }
FiPackageSpot >> shortPrintString [

	^ packageName
]
