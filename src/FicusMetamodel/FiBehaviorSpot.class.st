Class {
	#name : #FiBehaviorSpot,
	#superclass : #FiMetamodelSpot,
	#instVars : [
		'isMetaSide',
		'behaviorName'
	],
	#category : #'FicusMetamodel-Spots'
}

{ #category : #'as yet unclassified' }
FiBehaviorSpot class >> canInstantiateSpotFrom: steps ifTrue: aBlockClosure [ 
	
	steps size < 4 ifTrue: [ ^ false ].
	
	steps size = 4 ifTrue: [ 
		aBlockClosure value: 
			(FiBehaviorSpot 
				name: steps fourth 
				isMetaSide: false 
				packageName: steps second).
		^ true ].

	(steps size = 5 and: [ steps fifth = #metaclass ]) ifTrue: [ 
		aBlockClosure value: 
			(FiBehaviorSpot 
				name: steps fourth 
				isMetaSide: true
				packageName: steps second).
		^ true ].

	(steps size >= 5 and: [ steps fifth = #methods ]) ifTrue: [ ^ false ].
	(steps size >= 5 and: [ 
		steps fifth = #metaclass and: [ 
		steps sixth = #methods ]]) ifTrue: [ ^ false ].

	aBlockClosure value:
		((steps allButFirst: 4) 
			inject: 
				(FiBehaviorSpot 
					name: steps fourth 
					isMetaSide: true
					packageName: steps second)
			into: [ :spot :step | spot / step ]).
	^ true
]

{ #category : #'instance creation' }
FiBehaviorSpot class >> name: aBehaviorName isMetaSide: aBoolean packageName: aPackageName [

	^ self basicNew
		initializeWithName: aBehaviorName
		isMetaSide: aBoolean 
		packageName: aPackageName;
		yourself

]

{ #category : #comparing }
FiBehaviorSpot >> = other [

	^ super = other and: [ 
		self behaviorName = other behaviorName and: [ 
		self isMetaSide = other isMetaSide ] ]
]

{ #category : #converting }
FiBehaviorSpot >> asPackageSpot [
	
	^ FiPackageSpot named: packageName
]

{ #category : #converting }
FiBehaviorSpot >> asPathOn: anObject [

	^ anObject pathOfBehaviorSpot: self
]

{ #category : #accessing }
FiBehaviorSpot >> behaviorName [

	^ behaviorName
]

{ #category : #comparing }
FiBehaviorSpot >> hash [

	^ super hash bitXor: (
		self behaviorName hash bitXor:
		self isMetaSide hash)
]

{ #category : #initialization }
FiBehaviorSpot >> initializeWithName: aBehaviorName isMetaSide: aBoolean packageName: aPackageName [

	self initialize.
	
	behaviorName := aBehaviorName.
	isMetaSide := aBoolean.
	packageName := aPackageName.
]

{ #category : #accessing }
FiBehaviorSpot >> isMetaSide [

	^ isMetaSide
]

{ #category : #printing }
FiBehaviorSpot >> shortPrintString [

	^ String streamContents: [ :aStream |
		aStream nextPutAll: behaviorName.

		isMetaSide ifTrue: [
			aStream nextPutAll: ' class' ] ]
]
