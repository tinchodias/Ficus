"
A FiMetamodelSpotTest is a test class for testing the behavior of FiMetamodelSpot
"
Class {
	#name : #FiMetamodelSpotTest,
	#superclass : #TestCase,
	#category : #'FicusMetamodel-Tests'
}

{ #category : #tests }
FiMetamodelSpotTest >> testClassMethodPathAsSpot [

	self 
		assert: (FiPath root / #packages / #SomePackageName / #contents / #SomeBehaviorName / #metaclass / #methods / #someSelector) asMetamodelSpot
		equals: 
			(FiMethodSpot 
				selector: #someSelector
				behaviorName: #SomeBehaviorName
				isMetaSide: true
				packageName: #SomePackageName)
]

{ #category : #tests }
FiMetamodelSpotTest >> testClassMethodProtocolPathAsSpot [

	self 
		assert: (FiPath root / #packages / #SomePackageName / #contents / #SomeBehaviorName / #metaclass / #methods / #someSelector / #protocol) asMetamodelSpot
		equals: 
			(FiMethodSpot 
				selector: #someSelector
				behaviorName: #SomeBehaviorName
				isMetaSide: true
				packageName: #SomePackageName) / #protocol
]

{ #category : #tests }
FiMetamodelSpotTest >> testClassPathAsSpot [

	self 
		assert: (FiPath root / #packages / #SomePackageName / #contents / #SomeBehaviorName) asMetamodelSpot
		equals: 
			(FiBehaviorSpot 
				name: #SomeBehaviorName
				isMetaSide: false 
				packageName: #SomePackageName)
]

{ #category : #tests }
FiMetamodelSpotTest >> testInstanceMethodPathAsSpot [

	self 
		assert: (FiPath root / #packages / #SomePackageName / #contents / #SomeBehaviorName / #methods / #someSelector) asMetamodelSpot
		equals: 
			(FiMethodSpot 
				selector: #someSelector
				behaviorName: #SomeBehaviorName
				isMetaSide: false
				packageName: #SomePackageName)
]

{ #category : #tests }
FiMetamodelSpotTest >> testInstanceMethodProtocolPathAsSpot [

	self 
		assert: (FiPath root / #packages / #SomePackageName / #contents / #SomeBehaviorName / #methods / #someSelector / #protocol) asMetamodelSpot
		equals: 
			(FiMethodSpot 
				selector: #someSelector
				behaviorName: #SomeBehaviorName
				isMetaSide: false
				packageName: #SomePackageName) / #protocol
]

{ #category : #tests }
FiMetamodelSpotTest >> testMetaclassPathAsSpot [

	self 
		assert: (FiPath root / #packages / #SomePackageName / #contents / #SomeBehaviorName / #metaclass) asMetamodelSpot
		equals: 
			(FiBehaviorSpot 
				name: #SomeBehaviorName
				isMetaSide: true
				packageName: #SomePackageName)
]

{ #category : #tests }
FiMetamodelSpotTest >> testPackagePathAsSpot [

	self 
		assert: (FiPath root / #packages / #SomePackageName) asMetamodelSpot
		equals: (FiPackageSpot named: #SomePackageName)
]
