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

{ #category : #results }
FiEnvironment >> checkMethodEdit: aFiMethodEdit [ 
	
	self packages 
		valueAt: aFiMethodEdit packageName
		ifPresent: [ :package | 
			package contents 
				valueAt: aFiMethodEdit hostName 
				ifPresent: [ :x | "OK" ] 
				ifAbsent: [ self error: 'Class or trait not found' ] ]
		ifAbsent: [ self error: 'Package not found' ].

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

{ #category : #results }
FiEnvironment >> resultOfClassCreation: aFiClassCreation [ 

	| newPackage |
	newPackage := self packages 
		valueAt: aFiClassCreation packageName
		ifPresent: [ :package | 
			package resultOf: 
				(package 
					editAt: #contents 
					do: [ :set | set editInclude: aFiClassCreation newClass]) ]
		ifAbsent: [ 
			FiPackage builder
				name: aFiClassCreation packageName asSymbol;
				contents: { aFiClassCreation newClass } asFiSet;
				new ].
	
	^ self resultOf:
		(self 
			editAt: #packages 
			do: [ :set | set editInclude: newPackage ])
]

{ #category : #results }
FiEnvironment >> resultOfMethodCreation: aFiMethodCreation [ 

	| path |
	self checkMethodEdit: aFiMethodCreation.
		
	path := FiPath root / #packages / aFiMethodCreation packageName / #contents / aFiMethodCreation hostName. 
	path := 
		aFiMethodCreation isMetaSide
			ifTrue: [ path / #metaclass / #methods ]
			ifFalse: [ path / #methods ].		
		
	^ self resultOf: 
		(FiSubEdit 
			path: path
			edit: (FiInclude value: aFiMethodCreation newMethod))
]

{ #category : #results }
FiEnvironment >> resultOfMethodUpdate: aFiMethodUpdate [ 
	
	| path |
	self checkMethodEdit: aFiMethodUpdate.
		
	path := FiPath root / #packages / aFiMethodUpdate packageName / #contents / aFiMethodUpdate hostName. 
	path := 
		aFiMethodUpdate isMetaSide
			ifTrue: [ path / #metaclass / #methods ]
			ifFalse: [ path / #methods ].		
	path := path / aFiMethodUpdate selector.
		
	^ self resultOf: 
		(FiSubEdit 
			path: path
			edit: aFiMethodUpdate edit)
]
