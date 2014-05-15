Class {
	#name : #FiMarshalingVisitor,
	#superclass : #Object,
	#instVars : [
		'monticelloClasses',
		'monticelloMethodsByClassName',
		'monticelloMetaclassMethodsByClassName'
	],
	#category : #'FicusMonticello-Marshaling'
}

{ #category : #private }
FiMarshalingVisitor >> ficusClassFor: aMCClassDefinition [ 

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
FiMarshalingVisitor >> ficusClassPoolFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition classVarNames 
]

{ #category : #private }
FiMarshalingVisitor >> ficusLayoutFor: aMCClassDefinition [
			
	^ FiFixedLayout newFromStepsAndValues: 
		(Dictionary new
			at: #slotNames put: (self ficusSymbolSetFor: aMCClassDefinition instVarNames);
			yourself)
]

{ #category : #private }
FiMarshalingVisitor >> ficusMetaclassFor: aMCClassDefinition [ 

	^ FiMetaclass newFromStepsAndValues: 
		(Dictionary new
			at: #methods put: (self ficusMetaclassMethodsFor: aMCClassDefinition);
			at: #layout put: (self ficusMetaclassLayoutFor: aMCClassDefinition);
			at: #traitComposition put: aMCClassDefinition classTraitCompositionString;
			yourself)
]

{ #category : #private }
FiMarshalingVisitor >> ficusMetaclassLayoutFor: aMCClassDefinition [
			
	^ FiFixedLayout newFromStepsAndValues: 
		(Dictionary new
			at: #slotNames put: (self ficusSymbolSetFor: aMCClassDefinition classInstVarNames);
			yourself)
]

{ #category : #private }
FiMarshalingVisitor >> ficusMetaclassMethodsFor: aMCClassDefinition [ 
	
	^ self ficusMethodsForAll: 
		(monticelloMetaclassMethodsByClassName 
			at: aMCClassDefinition className
			ifAbsent: [ #() ]).

]

{ #category : #private }
FiMarshalingVisitor >> ficusMethodFor: aMCMethodDefinition [ 
	
	^ FiMethod newFromStepsAndValues: 
		(Dictionary new
			at: #selector put: aMCMethodDefinition selector;
			at: #protocol put: aMCMethodDefinition category;
			at: #sourceCode put: aMCMethodDefinition source;
			yourself)
]

{ #category : #private }
FiMarshalingVisitor >> ficusMethodsFor: aMCClassDefinition [ 
	
	^ self ficusMethodsForAll: 
		(monticelloMethodsByClassName 
			at: aMCClassDefinition className
			ifAbsent: [ #() ]).

]

{ #category : #private }
FiMarshalingVisitor >> ficusMethodsForAll: monticelloMethods [
	
	| ficusMethodsBySelector |
	ficusMethodsBySelector := Dictionary new.
	
	monticelloMethods do: [ :aMCMethodDefinition | 
		ficusMethodsBySelector
			at: aMCMethodDefinition selector
			put: (self ficusMethodFor: aMCMethodDefinition) ].
	
	^ FiDictionary newFromStepsAndValues: ficusMethodsBySelector
]

{ #category : #private }
FiMarshalingVisitor >> ficusSharedPoolsFor: aMCClassDefinition [ 

	^ self ficusSymbolSetFor: aMCClassDefinition poolDictionaries
]

{ #category : #private }
FiMarshalingVisitor >> ficusSymbolSetFor: aCollection [

	^ FiSet new values: (aCollection collect: #asSymbol as: Set) 
]

{ #category : #initialization }
FiMarshalingVisitor >> initialize [

	super initialize.
	
	monticelloClasses := Set new.
	monticelloMethodsByClassName := Dictionary new.
	monticelloMetaclassMethodsByClassName := Dictionary new.
]

{ #category : #building }
FiMarshalingVisitor >> result [
	
	| classByName |
	classByName := Dictionary new.

	monticelloClasses do: [ :each |
		classByName 
			at: each className
			put: (self ficusClassFor: each) ].
	
	^ FiDictionary newFromStepsAndValues: classByName
]

{ #category : #visitor }
FiMarshalingVisitor >> visitClassDefinition: aMCClassDefinition [ 
	
	monticelloClasses add: aMCClassDefinition
]

{ #category : #visitor }
FiMarshalingVisitor >> visitMetaclassDefinition: aMCClassDefinition [ 
	"Do nothing: it's enough to collect the instance-side"
]

{ #category : #visitor }
FiMarshalingVisitor >> visitMethodDefinition: aMCMethodDefinition [ 
	
	| aDictionary |
	aDictionary := 
		aMCMethodDefinition classIsMeta 
			ifFalse: [ monticelloMethodsByClassName ]
			ifTrue: [ monticelloMetaclassMethodsByClassName ].
	
	(aDictionary
		at: aMCMethodDefinition className
		ifAbsentPut: [ Set new ])
		add: aMCMethodDefinition 
]

{ #category : #visitor }
FiMarshalingVisitor >> visitOrganizationDefinition: aMCOrganizationDefinition [ 
	"Just ignore"
	
	self flag: #fix. "?"
]

{ #category : #visitor }
FiMarshalingVisitor >> visitTraitDefinition: aMCTraitDefinition [ 
	
	
	"self shouldBeImplemented.   TODO"
]
