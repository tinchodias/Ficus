Class {
	#name : #FiEpiceaTranslator,
	#superclass : #Object,
	#traits : 'EpTCodeChangeVisitor',
	#classTraits : 'EpTCodeChangeVisitor classTrait',
	#instVars : [
		'priorHistoryNode',
		'basePath'
	],
	#category : #FicusEpicea
}

{ #category : #'instance creation' }
FiEpiceaTranslator class >> newWithBasePath: aPath [

	^ self basicNew	
		initializeWithBasePath: aPath;
		yourself
]

{ #category : #private }
FiEpiceaTranslator >> editForMethodEqual: aRingMethod [
	
	^ FiSubEdit
		path: FiPath root / #contents / aRingMethod className / #methods
		edit: 
			(FiInclude value: 
				(FiMethod builder
					protocol: aRingMethod protocol asSymbol;
					sourceCode: aRingMethod sourceCode asString;
					new))
]

{ #category : #private }
FiEpiceaTranslator >> ficusClassPoolFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition classVarNames 
]

{ #category : #private }
FiEpiceaTranslator >> ficusLayoutFor: aMCClassDefinition [
			
	^ FiFixedLayout builder 
		instanceVariables: (self ficusSymbolSetFor: aMCClassDefinition instVarNames);
		new
]

{ #category : #private }
FiEpiceaTranslator >> ficusSharedPoolsFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition sharedPools
]

{ #category : #private }
FiEpiceaTranslator >> ficusSymbolSetFor: aCollection [

	^ FiSet withValues: (aCollection collect: #asSymbol as: Set) 
]

{ #category : #initialization }
FiEpiceaTranslator >> initializeWithBasePath: aPath [

	self initialize.
	
	basePath := aPath.
]

{ #category : #visitor }
FiEpiceaTranslator >> visitBehaviorChange: aChange [

	| aRingClass classPath |
	aRingClass := aChange behaviorAffected.	
	classPath := basePath / aRingClass name.

	^ FiCompositeEdit withAll: {
		FiSubEdit
			path: classPath / #superclassName
			equal: aRingClass superclassName.
		FiSubEdit
			path: classPath / #layout
			equal: (self ficusLayoutFor: aRingClass).
		FiSubEdit
			path: classPath / #category
			equal: aRingClass category.
		FiSubEdit
			path: classPath / #classPool
			equal: (self ficusClassPoolFor: aRingClass).
		FiSubEdit
			path: classPath / #sharedPools
			equal: (self ficusSharedPoolsFor: aRingClass).
			}
]

{ #category : #visitor }
FiEpiceaTranslator >> visitMethodCreated: aChange [

	^ self editForMethodEqual: aChange methodAdded
]

{ #category : #visitor }
FiEpiceaTranslator >> visitMethodModified: aChange [
	
	^ self editForMethodEqual: aChange newMethod
]

{ #category : #visitor }
FiEpiceaTranslator >> visitProtocolAddition: aProtocolAddition [

	^ FiNoEdit new
]

{ #category : #visitor }
FiEpiceaTranslator >> visitProtocolRemoval: aProtocolRemoved [

	^ FiNoEdit new
]
