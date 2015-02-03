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

	| path |
	self flag: #todo. 
	"Consider it can be an extension method (check method package = class package)"
	
	path := FiPath root / #contents / aRingMethod theNonMetaClassName. 
	path := 
		aRingMethod isMetaSide
			ifTrue: [ path / #metaclass / #methods ]
			ifFalse: [ path / #methods ].
	
	^ FiSubEdit
		path: path
		edit: 
			(FiInclude value: 
				(FiMethod builder
					protocol: aRingMethod protocol asSymbol;
					sourceCode: aRingMethod sourceCode asString;
					new))
]

{ #category : #private }
FiEpiceaTranslator >> ficusClassFor: aRGClassDefinition [ 

	^ FiClass builder
		theName: aRGClassDefinition name asSymbol;
		metaclass: (self ficusMetaclassFor: aRGClassDefinition);
		superclassName: aRGClassDefinition superclassName;
		layout: (self ficusLayoutFor: aRGClassDefinition);
		methods: FiSet new;
		traitComposition: aRGClassDefinition traitCompositionSource;
		category: aRGClassDefinition category;
		classPool: (self ficusClassPoolFor: aRGClassDefinition);
		sharedPools: (self ficusSharedPoolsFor: aRGClassDefinition);
		comment: '';
		new
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
FiEpiceaTranslator >> ficusMetaclassFor: aRGClassDefinition [ 

	^ FiMetaclass builder 
		methods: FiSet new;
		layout: (self ficusMetaclassLayoutFor: aRGClassDefinition);
		traitComposition: aRGClassDefinition theMetaClass traitCompositionSource; 
		new
]

{ #category : #private }
FiEpiceaTranslator >> ficusMetaclassLayoutFor: aRGClassDefinition [ 
			
	^ FiFixedLayout builder 
		instanceVariables: (self ficusSymbolSetFor: aRGClassDefinition theMetaClass instVarNames);
		new
		
]

{ #category : #private }
FiEpiceaTranslator >> ficusSharedPoolsFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition sharedPools
]

{ #category : #private }
FiEpiceaTranslator >> ficusSymbolSetFor: aCollection [

	^ (aCollection collect: #asSymbol as: Set) asFiSet
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
FiEpiceaTranslator >> visitBehaviorCommented: aChange [

	| aRingClass |
	aRingClass := aChange behaviorAffected.	

	^ FiSubEdit
		path: basePath / aRingClass name / #comment
		equal: aChange newComment
]

{ #category : #visitor }
FiEpiceaTranslator >> visitClassCreated: aClassAddition [

	| aFiClass |
	aFiClass := self ficusClassFor: aClassAddition behaviorAffected.

	^ FiSubEdit
		path: FiPath root / #contents
		edit: (FiInclude value: aFiClass)
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
