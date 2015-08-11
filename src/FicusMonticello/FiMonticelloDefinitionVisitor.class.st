Class {
	#name : #FiMonticelloDefinitionVisitor,
	#superclass : #Object,
	#instVars : [
		'monticelloClasses',
		'monticelloTraits',
		'monticelloExtensionMethodsByHostName',
		'monticelloMethodsByHostName',
		'monticelloMetaclassMethodsByHostName',
		'monticelloMetaclassExtensionMethodsByHostName'
	],
	#category : #'FicusMonticello-Writing'
}

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusBytesLayoutFor: aMCClassDefinition [
			
	^ FiBitsLayout builder 
		isWords: false;
		new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusClassFor: aMCClassDefinition [ 

	^ FiClass builder
		name: aMCClassDefinition className asSymbol;
		metaclass: (self ficusMetaclassFor: aMCClassDefinition);
		superclassName: aMCClassDefinition superclassName;
		layout: (self ficusLayoutFor: aMCClassDefinition);
		methods: (self ficusMethodsFor: aMCClassDefinition);
		traitComposition: aMCClassDefinition traitCompositionString;
		category: aMCClassDefinition category;
		classPool: (self ficusClassPoolFor: aMCClassDefinition);
		sharedPools: (self ficusSharedPoolsFor: aMCClassDefinition);
		comment: aMCClassDefinition ficusComment;
		new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusClassPoolFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition classVarNames 
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusClassTraitFor: aMCTraitDefinition [ 

	^ FiTrait builder
		methods: (self ficusClassTraitMethodsFor: aMCTraitDefinition);
		traitComposition: aMCTraitDefinition classTraitCompositionString;
		new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusClassTraitMethodsFor: aMCTraitDefinition [

	^ self ficusMethodsForAll: 
		(monticelloMetaclassMethodsByHostName 
			at: aMCTraitDefinition className
			ifAbsent: [ #() ]).

]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusCompiledMethodLayoutFor: aMCClassDefinition [
			
	^ FiCompiledMethodLayout new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusExtensionMethodsForHostName: hostName methods: someMCMethodDefinitions isMetaSide: aBoolean [
	
	^ FiExtensionMethods builder
		hostName: hostName;
		methods: (self ficusMethodsForAll: someMCMethodDefinitions);
		isMetaSide: aBoolean;
		new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusFixedLayoutFor: aMCClassDefinition [
			
	^ FiFixedLayout builder 
		instanceVariables: (self ficusInstanceVariableSetFor: aMCClassDefinition instVarNames);
		new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusInstanceVariableSetFor: aCollection [

	^ ((aCollection collectWithIndex: [ :each :index |
			FiInstanceVariable builder
				index: index;
				name: each asSymbol;
				new ]) as: Set) asFiSet
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusLayoutFor: aMCClassDefinition [
			
	| type |
	type := aMCClassDefinition type.
	type = #normal ifTrue: [^ self ficusFixedLayoutFor: aMCClassDefinition ].
	type = #words ifTrue: [^ self ficusWordsLayoutFor: aMCClassDefinition ].
	type = #variable ifTrue: [^ self ficusVariableLayoutFor: aMCClassDefinition ].
	type = #bytes ifTrue: [^ self ficusBytesLayoutFor: aMCClassDefinition ].
	type = #weak ifTrue: [^ self ficusWeakLayoutFor: aMCClassDefinition ].
	type = #compiledMethod ifTrue: [^ self ficusCompiledMethodLayoutFor: aMCClassDefinition ].
	Error signal: ('Unrecognized class type: {1}' format: {type})
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusMetaclassFor: aMCClassDefinition [ 

	^ FiMetaclass builder 
		methods: (self ficusMetaclassMethodsFor: aMCClassDefinition);
		layout: (self ficusMetaclassLayoutFor: aMCClassDefinition);
		traitComposition: aMCClassDefinition classTraitCompositionString;
		new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusMetaclassLayoutFor: aMCClassDefinition [
			
	^ FiFixedLayout builder 
		instanceVariables: (self ficusInstanceVariableSetFor: aMCClassDefinition classInstVarNames);
		new
		
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusMetaclassMethodsFor: aMCClassDefinition [ 
	
	^ self ficusMethodsForAll: 
		(monticelloMetaclassMethodsByHostName 
			at: aMCClassDefinition className
			ifAbsent: [ #() ]).

]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusMethodFor: aMCMethodDefinition [ 
	
	^ FiMethod
		sourceCode: aMCMethodDefinition ficusSource
		protocol: aMCMethodDefinition category

]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusMethodsFor: aMCClassDefinition [ 
	
	^ self ficusMethodsForAll: 
		(monticelloMethodsByHostName 
			at: aMCClassDefinition className
			ifAbsent: [ #() ]).

]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusMethodsForAll: monticelloMethods [
	
	^ (monticelloMethods 
		collect: [ :aMCMethodDefinition | self ficusMethodFor: aMCMethodDefinition ]) 
		asFiSet
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusPackageContents [
	
	| children |
	children := OrderedCollection new.

	monticelloClasses do: [ :each |
		children add: (self ficusClassFor: each) ].

	monticelloTraits do: [ :each |
		children add: (self ficusTraitFor: each) ].

	monticelloExtensionMethodsByHostName keysAndValuesDo: [ :hostName :each |
		children add: (self ficusExtensionMethodsForHostName: hostName methods: each isMetaSide: false) ].

	monticelloMetaclassExtensionMethodsByHostName keysAndValuesDo: [ :hostName :each |
		children add: (self ficusExtensionMethodsForHostName: hostName methods: each isMetaSide: true) ].
	
	^ children asFiSet
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusSharedPoolsFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition poolDictionaries
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusSymbolSetFor: aCollection [

	^ (aCollection collect: #asSymbol as: Set) asFiSet
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusTraitFor: aMCTraitDefinition [ 

	^ FiTrait builder
		name: aMCTraitDefinition className;
		methods: (self ficusMethodsFor: aMCTraitDefinition);
		classTrait: (self ficusClassTraitFor: aMCTraitDefinition);
		traitComposition: aMCTraitDefinition traitCompositionString;
		category: aMCTraitDefinition category;
		comment: aMCTraitDefinition comment;
		new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusVariableLayoutFor: aMCClassDefinition [
			
	^ FiVariableLayout builder 
		instanceVariables: (self ficusInstanceVariableSetFor: aMCClassDefinition instVarNames);
		new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusWeakLayoutFor: aMCClassDefinition [
			
	^ FiWeakVariableLayout builder 
		instanceVariables: (self ficusInstanceVariableSetFor: aMCClassDefinition instVarNames);
		new
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusWordsLayoutFor: aMCClassDefinition [
			
	^ FiBitsLayout builder 
		isWords: true;
		new
]

{ #category : #initialization }
FiMonticelloDefinitionVisitor >> initialize [

	super initialize.
	
	monticelloClasses := Set new.
	monticelloTraits := Set new.

	monticelloMethodsByHostName := Dictionary new.
	monticelloMetaclassMethodsByHostName := Dictionary new.

	monticelloExtensionMethodsByHostName := Dictionary new.
	monticelloMetaclassExtensionMethodsByHostName := Dictionary new.
]

{ #category : #visitor }
FiMonticelloDefinitionVisitor >> visitClassDefinition: aMCClassDefinition [ 
	
	monticelloClasses add: aMCClassDefinition
]

{ #category : #visitor }
FiMonticelloDefinitionVisitor >> visitClassTraitDefinition: aMCClassTraitDefinition [ 
	
	self flag: #todo. "this should *not* be ignored"
]

{ #category : #visitor }
FiMonticelloDefinitionVisitor >> visitMetaclassDefinition: aMCClassDefinition [ 
	"Do nothing: it's enough to collect the instance-side"
]

{ #category : #visitor }
FiMonticelloDefinitionVisitor >> visitMethodDefinition: aMCMethodDefinition [ 
	
	| aDictionary |
	aDictionary := 
		aMCMethodDefinition isExtensionMethod
			ifTrue: [ 
				aMCMethodDefinition classIsMeta
 					ifFalse: [ monticelloExtensionMethodsByHostName ]
					ifTrue: [ monticelloMetaclassExtensionMethodsByHostName ] ]
			ifFalse: [
				aMCMethodDefinition classIsMeta 
					ifFalse: [ monticelloMethodsByHostName ]
					ifTrue: [ monticelloMetaclassMethodsByHostName ] ].
	
	(aDictionary
		at: aMCMethodDefinition className
		ifAbsentPut: [ Set new ])
		add: aMCMethodDefinition 
]

{ #category : #visitor }
FiMonticelloDefinitionVisitor >> visitOrganizationDefinition: aMCOrganizationDefinition [ 
	"Just ignore"
	
	self flag: #todo. "?"
]

{ #category : #visitor }
FiMonticelloDefinitionVisitor >> visitTraitDefinition: aMCTraitDefinition [ 
	
	monticelloTraits add: aMCTraitDefinition
]
