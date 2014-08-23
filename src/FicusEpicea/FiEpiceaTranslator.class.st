Class {
	#name : #FiEpiceaTranslator,
	#superclass : #Object,
	#traits : 'EpTCodeChangeVisitor',
	#classTraits : 'EpTCodeChangeVisitor classTrait',
	#instVars : [
		'priorHistoryNode'
	],
	#category : #FicusEpicea
}

{ #category : #'instance creation' }
FiEpiceaTranslator class >> newWithPrior: aHistoryNode [ 
	
	^ self basicNew
		initializeWith: aHistoryNode;
		yourself
]

{ #category : #'as yet unclassified' }
FiEpiceaTranslator >> ficusClassFor: aMCClassDefinition [ 

	^ FiClass builder
		theName: aMCClassDefinition className;
		metaclass: (self ficusMetaclassFor: aMCClassDefinition);
		superclassName: aMCClassDefinition superclassName;
		layout: (self ficusLayoutFor: aMCClassDefinition);
		methods: (self ficusMethodsFor: aMCClassDefinition);
		traitComposition: aMCClassDefinition traitCompositionSource;
		category: aMCClassDefinition category;
		classPool: (self ficusClassPoolFor: aMCClassDefinition);
		sharedPools: (self ficusSharedPoolsFor: aMCClassDefinition);
		comment: aMCClassDefinition comment;
		new
]

{ #category : #'as yet unclassified' }
FiEpiceaTranslator >> ficusClassPoolFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition classVarNames 
]

{ #category : #'as yet unclassified' }
FiEpiceaTranslator >> ficusLayoutFor: aMCClassDefinition [
			
	^ FiFixedLayout builder 
		slotNames: (self ficusSymbolSetFor: aMCClassDefinition instVarNames);
		new
]

{ #category : #'as yet unclassified' }
FiEpiceaTranslator >> ficusMetaclassFor: aMCClassDefinition [ 

	^ FiMetaclass builder 
		methods: (self ficusMetaclassMethodsFor: aMCClassDefinition);
		layout: (self ficusMetaclassLayoutFor: aMCClassDefinition);
		traitComposition: aMCClassDefinition theMetaClass traitCompositionSource;
		new
]

{ #category : #'as yet unclassified' }
FiEpiceaTranslator >> ficusMetaclassLayoutFor: aMCClassDefinition [
			
	^ FiFixedLayout builder 
		slotNames: (self ficusSymbolSetFor: aMCClassDefinition theMetaClass instVarNames );
		new
		
]

{ #category : #'as yet unclassified' }
FiEpiceaTranslator >> ficusMetaclassMethodsFor: aMCClassDefinition [ 
	
	^ priorHistoryNode snapshot contents 
		shotAt: aMCClassDefinition name
		ifPresent: [ :aClass | aClass metaclass methods ]
		ifAbsent: [ FiSet new ]
]

{ #category : #'as yet unclassified' }
FiEpiceaTranslator >> ficusMethodsFor: aMCClassDefinition [ 
	
	^ priorHistoryNode snapshot contents 
		shotAt: aMCClassDefinition name
		ifPresent: [ :aClass | aClass methods ]
		ifAbsent: [ FiSet new ]
]

{ #category : #'as yet unclassified' }
FiEpiceaTranslator >> ficusSharedPoolsFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition sharedPools
]

{ #category : #'as yet unclassified' }
FiEpiceaTranslator >> ficusSymbolSetFor: aCollection [

	^ FiSet withValues: (aCollection collect: #asSymbol as: Set) 
]

{ #category : #initialization }
FiEpiceaTranslator >> initializeWith: aHistoryNode [
	
	self initialize.
	
	priorHistoryNode := aHistoryNode.
	
]

{ #category : #visitor }
FiEpiceaTranslator >> resultOfClassEqual: aRingClass [
	
	| priorSnapshot edit |
	priorSnapshot := priorHistoryNode snapshot.

	edit := priorSnapshot
		at: #contents
		edit: [ :contents |
			contents include: (self ficusClassFor: aRingClass) ].
						
	^ priorSnapshot resultOf: edit
]

{ #category : #visitor }
FiEpiceaTranslator >> resultOfMethodEqual: aRingMethod [
	
	| priorSnapshot edit |
	priorSnapshot := priorHistoryNode snapshot.
	
	edit := priorSnapshot
		at: #contents
		edit: [ :contents |
			contents 
				at: aRingMethod className
				edit: [ :aClassOrTrait |
					aClassOrTrait 
						at: #methods
						edit: [ :methods |
							methods include: 
								(FiMethod builder
									protocol: aRingMethod protocol asSymbol;
									sourceCode: aRingMethod sourceCode asString;
									new) ] ] ].
						
	^ priorSnapshot resultOf: edit
]

{ #category : #visitor }
FiEpiceaTranslator >> visitBehaviorChange: aChange [

	^ self resultOfClassEqual: aChange behaviorAffected 
]

{ #category : #visitor }
FiEpiceaTranslator >> visitMethodCreated: aChange [

	^ self resultOfMethodEqual: aChange methodAdded
]

{ #category : #visitor }
FiEpiceaTranslator >> visitMethodModified: aChange [
	
	^ self resultOfMethodEqual: aChange newMethod
]
