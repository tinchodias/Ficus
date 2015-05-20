Class {
	#name : #FiMethodSpot,
	#superclass : #FiMetamodelSpot,
	#instVars : [
		'selector',
		'behaviorName',
		'isMetaSide'
	],
	#category : #'FicusMetamodel-Spots'
}

{ #category : #'as yet unclassified' }
FiMethodSpot class >> canInstantiateSpotFrom: steps ifTrue: aBlockClosure [ 
	
	steps size < 6 ifTrue: [ ^ false ].
	
	(steps size >= 6 and: [ steps fifth = #methods ]) ifTrue: [ 
		aBlockClosure value:
			((steps allButFirst: 6) 
				inject: 
					(FiMethodSpot 
						selector: steps sixth
						behaviorName: steps fourth
						isMetaSide: false
						packageName: steps second)
				into: [ :spot :step | spot / step ]).
		^ true ].

	(steps size >= 7 and: [ steps sixth = #methods ]) ifTrue: [ 
		aBlockClosure value: 
			((steps allButFirst: 7)
				inject: 
					(FiMethodSpot 
						selector: steps seventh
						behaviorName: steps fourth
						isMetaSide: true
						packageName: steps second)
				into: [ :spot :step | spot / step ]).
		^ true ].

"	(steps size = 5 and: [ steps fifth = #metaclass ]) ifTrue: [ 
		aBlockClosure value: 
			(FiBehaviorSpot 
				name: steps fourth 
				isMetaSide: true
				packageName: steps second).
		^ true ].

	(steps size >= 5 and: [ steps fifth = #methods ]) ifTrue: [ ^ false ].
	"
	^ self notYetImplemented 
]

{ #category : #'instance creation' }
FiMethodSpot class >> selector: aSelector behaviorName: aBehaviorName isMetaSide: aBoolean packageName: aPackageName [

	^ self basicNew
		initializeWithSelector: aSelector 
		behaviorName: aBehaviorName 
		isMetaSide: aBoolean 
		packageName: aPackageName;
		yourself
]

{ #category : #comparing }
FiMethodSpot >> = other [

	^ super = other and: [ 
		self behaviorName = other behaviorName and: [ 
		self isMetaSide = other isMetaSide and: [ 
		self selector = other selector ] ] ]
]

{ #category : #converting }
FiMethodSpot >> asBehaviorSpot [

	^ FiBehaviorSpot 
		name: behaviorName
		isMetaSide: isMetaSide
		packageName: packageName
]

{ #category : #converting }
FiMethodSpot >> asPathOn: anObject [ 
	
	^ anObject pathOfMethodSpot: self
]

{ #category : #accessing }
FiMethodSpot >> behaviorName [

	^ behaviorName
]

{ #category : #comparing }
FiMethodSpot >> hash [

	^ super hash bitXor: 
		(self behaviorName hash bitXor: 
		(self isMetaSide hash bitXor:
		self selector hash))
]

{ #category : #initialization }
FiMethodSpot >> initializeWithSelector: aSelector behaviorName: aBehaviorName isMetaSide: aBoolean packageName: aPackageName [

	self initialize.
	
	selector := aSelector.
	behaviorName := aBehaviorName.
	isMetaSide := aBoolean.
	packageName := aPackageName.
]

{ #category : #accessing }
FiMethodSpot >> isMetaSide [

	^ isMetaSide
]

{ #category : #accessing }
FiMethodSpot >> selector [

	^ selector
]

{ #category : #printing }
FiMethodSpot >> shortPrintString [

	^ String streamContents: [ :aStream |
		aStream nextPutAll: behaviorName.

		isMetaSide ifTrue: [
			aStream nextPutAll: ' class' ].
		
		aStream
			nextPutAll: '>>';
			nextPutAll: selector ]
]
