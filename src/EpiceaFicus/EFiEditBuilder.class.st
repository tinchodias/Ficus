Class {
	#name : #EFiEditBuilder,
	#superclass : #Object,
	#category : #'EpiceaFicus-Monitors'
}

{ #category : #'as yet unclassified' }
EFiEditBuilder >> behaviorCategoryUpdateIn: aRingClass to: newCategory [ 

	^ FiSubEdit 
		path: (FiBehaviorSpot 
					name: aRingClass name 
					isMetaSide: false 
					packageName: aRingClass package) / #category
		edit: (FiEqual value: newCategory)
]

{ #category : #building }
EFiEditBuilder >> behaviorCommentUpdateIn: aRingClass to: newComment [

	^ FiSubEdit 
		path: (FiBehaviorSpot 
					name: aRingClass name 
					isMetaSide: false 
					packageName: aRingClass package) / #comment
		edit: (FiEqual value: newComment)
]

{ #category : #building }
EFiEditBuilder >> classCreation: aRingClass [

	^ FiSubEdit 
		path: (FiPackageSpot named: aRingClass package) / #contents
		edit: (FiInclude value: (self ficusClassFor: aRingClass))
]

{ #category : #building }
EFiEditBuilder >> classRemoval: aRingClass [

	^ FiSubEdit 
		path: (FiPackageSpot name: aRingClass package) / #contents
		edit: (FiExclude value: aRingClass theNonMetaClassName)
]

{ #category : #building }
EFiEditBuilder >> classUpdateFrom: oldRingClass to: newRingClass [

	|edit|
	self assert: oldRingClass isMeta not. "Should be implemented"
	
	edit := FiEdit fromAllAssociations: {
		#superclassName -> newRingClass superclassName.
		#layout -> (self ficusLayoutFor: newRingClass).
		#traitComposition -> newRingClass traitCompositionSource.
		#category -> newRingClass category.
		#classPool -> (self ficusClassPoolFor: newRingClass).
		#sharedPools -> (self ficusSharedPoolsFor: newRingClass).
		}.

	^ FiSubEdit 
		path: (FiBehaviorSpot 
					name: oldRingClass name 
					isMetaSide: oldRingClass isMeta 
					packageName: oldRingClass package)
		edit: edit
]

{ #category : #private }
EFiEditBuilder >> ficusClassFor: aRGClassDefinition [ 

	^ FiClass builder
		name: aRGClassDefinition name asSymbol;
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
EFiEditBuilder >> ficusClassPoolFor: aRGClassDefinition [ 

	^ self ficusSymbolSetFor: aRGClassDefinition classVarNames 
]

{ #category : #private }
EFiEditBuilder >> ficusLayoutFor: aRGClassDefinition [
			
	^ FiFixedLayout builder 
		instanceVariables: (self ficusSymbolSetFor: aRGClassDefinition instVarNames);
		new
]

{ #category : #private }
EFiEditBuilder >> ficusMetaclassFor: aRGClassDefinition [ 

	^ FiMetaclass builder 
		methods: FiSet new;
		layout: (self ficusMetaclassLayoutFor: aRGClassDefinition);
		traitComposition: aRGClassDefinition theMetaClass traitCompositionSource; 
		new
]

{ #category : #private }
EFiEditBuilder >> ficusMetaclassLayoutFor: aRGClassDefinition [ 
			
	^ FiFixedLayout builder 
		instanceVariables: (self ficusSymbolSetFor: aRGClassDefinition theMetaClass instVarNames);
		new
		
]

{ #category : #private }
EFiEditBuilder >> ficusMethodFor: aRingMethod [

	^ FiMethod
		sourceCode: aRingMethod sourceCode asString
		protocol: aRingMethod protocol asSymbol
]

{ #category : #private }
EFiEditBuilder >> ficusSharedPoolsFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition sharedPools
]

{ #category : #private }
EFiEditBuilder >> ficusSymbolSetFor: aCollection [

	^ (aCollection collect: #asSymbol as: Set) asFiSet
]

{ #category : #private }
EFiEditBuilder >> ficusTraitFor: aRGTraitDefinition [ 

	^ FiTrait builder
		name: aRGTraitDefinition name asSymbol;
		methods: FiSet new;
		traitComposition: aRGTraitDefinition traitCompositionSource;
		category: aRGTraitDefinition category;
		comment: '';
		new
]

{ #category : #building }
EFiEditBuilder >> methodCreation: aRingMethod [

	^ FiSubEdit 
		path: (FiBehaviorSpot
			name: aRingMethod theNonMetaClassName
			isMetaSide: aRingMethod isMetaSide
			packageName: aRingMethod package) / #methods
		edit: (FiInclude value: (self ficusMethodFor: aRingMethod))
]

{ #category : #building }
EFiEditBuilder >> methodRemoval: aRingMethod [

	| workaroundPackageName |
	self flag: #todo. "The removed method comes with nil as package..."
	workaroundPackageName := aRingMethod methodClass package name.
	
	^ FiSubEdit 
		path: (FiBehaviorSpot
			name: aRingMethod theNonMetaClassName
			isMetaSide: aRingMethod isMetaSide
			packageName: workaroundPackageName) / #methods
		edit: (FiExclude value: aRingMethod selector)
]

{ #category : #building }
EFiEditBuilder >> methodUpdateFrom: oldRingMethod to: newRingMethod [

	|edit|
	edit := FiEdit fromAllAssociations: {
		#sourceCode -> newRingMethod sourceCode asString.
		#protocol -> newRingMethod protocol asSymbol.
		}.

	^ FiSubEdit 
		path: (FiMethodSpot 
			selector: oldRingMethod selector
			behaviorName: oldRingMethod theNonMetaClassName
			isMetaSide: oldRingMethod isMetaSide
			packageName: oldRingMethod package)
		edit: edit
]

{ #category : #building }
EFiEditBuilder >> traitCreation: aRingTrait [

	^ FiSubEdit 
		path: (FiPackageSpot name: aRingTrait package) / #contents
		edit: (FiInclude value: (self ficusTraitFor: aRingTrait))
]

{ #category : #building }
EFiEditBuilder >> traitRemoval: aRingTrait [

	^ FiSubEdit 
		path: (FiPackageSpot name: aRingTrait package) / #contents
		edit: (FiExclude value: aRingTrait theNonMetaClassName)
]

{ #category : #building }
EFiEditBuilder >> traitUpdateFrom: oldRingTrait to: newRingTrait [

	|edit|
	self assert: oldRingTrait isMetaSide not. "Should be implemented"
	
	edit := FiEdit fromAllAssociations: {
		#traitComposition -> newRingTrait traitCompositionSource.
		#category -> newRingTrait category.
		}.

	^ FiSubEdit 
		path: (FiBehaviorSpot name: oldRingTrait name packageName: oldRingTrait package)
		edit: edit
]
