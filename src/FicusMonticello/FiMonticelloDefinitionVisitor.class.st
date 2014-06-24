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
	#category : #'FicusMonticello-Marshaling'
}

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusClassFor: aMCClassDefinition [ 

	^ FiClass newFromStepsAndValues: 
		(Dictionary new
			at: #theName put: aMCClassDefinition className;
			at: #metaclass put: (self ficusMetaclassFor: aMCClassDefinition);
			at: #superclass put: aMCClassDefinition superclassName;
			at: #layout put: (self ficusLayoutFor: aMCClassDefinition);
			at: #methods put: (self ficusMethodsFor: aMCClassDefinition);
			at: #traitComposition put: aMCClassDefinition traitCompositionString;
			at: #category put: aMCClassDefinition category;
			at: #classPool put: (self ficusClassPoolFor: aMCClassDefinition);
			at: #sharedPools put: (self ficusSharedPoolsFor: aMCClassDefinition);
			at: #comment put: aMCClassDefinition comment;
			yourself)
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusClassPoolFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition classVarNames 
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusExtensionMethodsForHostName: hostName methods: someMCMethodDefinitions isMetaSide: aBoolean [
	
	^ FiExtensionMethods newFromStepsAndValues: 
		(Dictionary new
			at: #hostName put: hostName;
			at: #methods put: (self ficusMethodsForAll: someMCMethodDefinitions);
			at: #isMetaSide put: aBoolean;
			yourself)
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusLayoutFor: aMCClassDefinition [
			
	^ FiFixedLayout newFromStepsAndValues: 
		(Dictionary new
			at: #slotNames put: (self ficusSymbolSetFor: aMCClassDefinition instVarNames);
			yourself)
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusMetaclassFor: aMCClassDefinition [ 

	^ FiMetaclass newFromStepsAndValues: 
		(Dictionary new
			at: #methods put: (self ficusMetaclassMethodsFor: aMCClassDefinition);
			at: #layout put: (self ficusMetaclassLayoutFor: aMCClassDefinition);
			at: #traitComposition put: aMCClassDefinition classTraitCompositionString;
			yourself)
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusMetaclassLayoutFor: aMCClassDefinition [
			
	^ FiFixedLayout newFromStepsAndValues: 
		(Dictionary new
			at: #slotNames put: (self ficusSymbolSetFor: aMCClassDefinition classInstVarNames);
			yourself)
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
	
	^ FiMethod newFromStepsAndValues: 
		(Dictionary new
			at: #selector put: aMCMethodDefinition selector;
			at: #protocol put: aMCMethodDefinition category;
			at: #sourceCode put: aMCMethodDefinition source;
			yourself)
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
	
	^ FiSet withValues: 
		(monticelloMethods collect: [ :aMCMethodDefinition | 
			self ficusMethodFor: aMCMethodDefinition ])
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
	
	^ FiSet withValues: children
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusSharedPoolsFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition poolDictionaries
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusSymbolSetFor: aCollection [

	^ FiSet withValues: (aCollection collect: #asSymbol as: Set) 
]

{ #category : #private }
FiMonticelloDefinitionVisitor >> ficusTraitFor: aMCTraitDefinition [ 

	^ FiTrait newFromStepsAndValues: 
		(Dictionary new
			at: #theName put: aMCTraitDefinition className;
			at: #methods put: (self ficusMethodsFor: aMCTraitDefinition);
			at: #traitComposition put: aMCTraitDefinition traitCompositionString;
			at: #category put: aMCTraitDefinition category;
			at: #comment put: aMCTraitDefinition comment;
			yourself)
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
