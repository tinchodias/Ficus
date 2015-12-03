"
I represent an environment. I contain all metamodel entities, e.g. packages, classes, traits, methods.
"
Class {
	#name : #FiEnvironment,
	#superclass : #FiFixedObject,
	#instVars : [
		'packages'
	],
	#category : #'FicusMetamodel-Core'
}

{ #category : #'instance creation' }
FiEnvironment class >> withAll: aCollection [ 
	
	^ self builder
		packages: aCollection asFiSet;
		new
]

{ #category : #accessing }
FiEnvironment >> packages [

	^ packages
]

{ #category : #paths }
FiEnvironment >> pathOfBehaviorSpot: aFiBehaviorSpot [ 

	| path |
	self flag: #todo. "This method should be in a more reusable place. Class-side?"

	path := FiPath root / #packages / aFiBehaviorSpot packageName / #contents / aFiBehaviorSpot behaviorName.

	^ aFiBehaviorSpot isMetaSide
			ifTrue: [ path / #metaclass ]
			ifFalse: [ path ].
	
]

{ #category : #paths }
FiEnvironment >> pathOfMethodSpot: aFiMethodSpot [ 

	| path |
	self flag: #todo. "This method should be in a more reusable place. Class-side?"

	path := FiPath root / #packages / aFiMethodSpot packageName / #contents / aFiMethodSpot behaviorName.

	path := 
		aFiMethodSpot isMetaSide
			ifTrue: [ path / #metaclass / #methods ]
			ifFalse: [ path / #methods ].
	
	^ path / aFiMethodSpot selector
]

{ #category : #paths }
FiEnvironment >> pathOfPackageSpot: aFiPackageSpot [ 

	^ FiPath root / #packages / aFiPackageSpot packageName
]

{ #category : #printing }
FiEnvironment >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		print: packages size;
		nextPut: $).
	
]
