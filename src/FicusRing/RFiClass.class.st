"
I am polymorphic with Class, fetching everything needed from a Ficus environment.
"
Class {
	#name : #RFiClass,
	#superclass : #RFiBehavior,
	#instVars : [
		'environment',
		'cachedSuperclass',
		'cachedMetaClass',
		'cachedSubclasses',
		'cachedClassVariables',
		'ficusClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #'instance creation' }
RFiClass class >> environment: aRFiEnvironment ficusClass: aFiClass [

	^ self basicNew
		initializeWithEnvironment: aRFiEnvironment 
		ficusClass: aFiClass;
		yourself
]

{ #category : #comparing }
RFiClass >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	self flag: #todo. "The == may be a wrong assumption"
	^ environment == other environment 
		and: [ ficusClass == other ficusClass ]
]

{ #category : #polymorphism }
RFiClass >> allInstVarNames [

	^ ficusClass hasNullSuperclass
		ifTrue: [ self instVarNames ]
		ifFalse: [ self superclass allInstVarNames, self instVarNames ].

]

{ #category : #polymorphism }
RFiClass >> allSelectors [
	"Answer all selectors understood by instances of the receiver"

	| result |
	result := IdentitySet new.

	self withAllSuperclasses do: [ :aClass | 
		result addAll: aClass selectors ].

	^ result
]

{ #category : #polymorphism }
RFiClass >> allSubclasses [

	^ Array streamContents: [ :stream |
		self allSubclassesDo: [ :each | stream nextPut: each ] ]
]

{ #category : #polymorphism }
RFiClass >> allSubclassesDo: aBlock [ 
	"Evaluate the argument, aBlock, for each of the receiver's subclasses."

	self subclassesDo: [ :aSubclass | 
		aBlock value: aSubclass.
		aSubclass allSubclassesDo: aBlock ]
]

{ #category : #polymorphism }
RFiClass >> allSuperclasses [

	^ Array streamContents: [ :stream |
		self allSuperclassesDo: [ :each | stream nextPut: each ] ]
]

{ #category : #polymorphism }
RFiClass >> allSuperclassesDo: aBlock [ 
	"Evaluate the argument, aBlock, for each of the receiver's superclasses."

	ficusClass hasNullSuperclass ifFalse: [
		aBlock value: self superclass.
		self superclass allSuperclassesDo: aBlock ]
]

{ #category : #converting }
RFiClass >> asString [

	^ self name
]

{ #category : #polymorphism }
RFiClass >> binding [
	"Answer a binding for the receiver, sharing if possible"

	| binding |
	binding := self environment 
		associationAt: self name 
		ifAbsent: [nil -> self].

	^ binding value == self 
		ifTrue: [binding] 
		ifFalse: [nil -> self]
]

{ #category : #polymorphism }
RFiClass >> bindingOf: varName [
	"Answer the binding of some variable resolved in the scope of the receiver, or nil
	if variable with such name is not defined"

	"The lookup recurses up to superclasses looking inside their class and shared pools,
	but not the environment, since two classes, even if they have ancestry relationship,
	could use different environments.
	That's why we doing an environment lookup only as a last step of symbol lookup 
	and taking only the environment of receiver only, not any of it's superclass(es) "
	
	| aSymbol |
	aSymbol := varName asSymbol.

	^ (self innerBindingOf: aSymbol) ifNil: [
		 self environment bindingOf: aSymbol ]
]

{ #category : #polymorphism }
RFiClass >> canUnderstand: aSymbol [

	self withAllSuperclasses do: [ :aClass |
		(aClass includesSelector: aSymbol) ifTrue: [ ^ true ] ].
	
	^ false
]

{ #category : #polymorphism }
RFiClass >> category [

	^ ficusClass category
]

{ #category : #polymorphism }
RFiClass >> classPool [

	^ ficusClass classPool 
		inject: Dictionary new
		into: [ :dictionary :each |
			dictionary 
				at: each put: nil;
				yourself ]
]

{ #category : #polymorphism }
RFiClass >> classVarNames [

	^ ficusClass classPool values
]

{ #category : #polymorphism }
RFiClass >> classVariableNamed: aString [
	"Copied from TClass"

	^self classPool associationAt: aString asSymbol ifAbsent: [self error: 'no such class var']
]

{ #category : #polymorphism }
RFiClass >> comment [

	^ ficusClass comment
]

{ #category : #polymorphism }
RFiClass >> definition [
	"Answer a String that defines the receiver."

	| aStream |
	aStream := (String new: 800) writeStream.
	self superclass 
		ifNil: [aStream nextPutAll: 'ProtoObject']
		ifNotNil: [aStream nextPutAll: self superclass name].
	aStream nextPutAll: self kindOfSubclass;
			store: self name.
	(self hasTraitComposition) ifTrue: [
		aStream cr; tab; nextPutAll: 'uses: ';
			nextPutAll: self traitCompositionString].
	aStream cr; tab; nextPutAll: 'instanceVariableNames: ';
			store: self instanceVariablesString.
	aStream cr; tab; nextPutAll: 'classVariableNames: ';
			store: self classVariablesString.
	aStream cr; tab; nextPutAll: 'poolDictionaries: ';
			store: self sharedPoolsString.
	aStream cr; tab; nextPutAll: 'category: ';
			store: self category asString.

	self superclass ifNil: [ 
		aStream nextPutAll: '.'; cr.
		aStream nextPutAll: self name.
		aStream space; nextPutAll: 'superclass: nil'. ].

	^ aStream contents
]

{ #category : #polymorphism }
RFiClass >> environment [
	
	^ environment
]

{ #category : #polymorphism }
RFiClass >> environment: anObject [
	
	environment := anObject
]

{ #category : #accessing }
RFiClass >> ficusClass [
	
	^ ficusClass
]

{ #category : #accessing }
RFiClass >> ficusPathFromEnvironment [
	
	^ environment ficusPathToClass: self
]

{ #category : #polymorphism }
RFiClass >> hasAbstractMethods [
	"Tells whether the receiver locally defines an abstract method, i.e., a method sending subclassResponsibility"
	^ super hasAbstractMethods or: [self class hasAbstractMethods]

]

{ #category : #polymorphism }
RFiClass >> hasComment [
	
	^ ficusClass comment isNotEmpty
]

{ #category : #comparing }
RFiClass >> hash [

	self flag: #todo. "The ==/identityHash may be a wrong assumption"

	^ (self class hash 
		bitXor: environment identityHash)
		bitXor: ficusClass identityHash
]

{ #category : #initialization }
RFiClass >> initializeWithEnvironment: aRFiEnvironment ficusClass: aFiClass [

	self initialize.
	
	environment := aRFiEnvironment.
	ficusClass := aFiClass.
]

{ #category : #polymorphism }
RFiClass >> innerBindingOf: aSymbol [
	"Answer the binding of some variable resolved in the scope of the receiver, or one of its superclass
	but do not look up binding in receiver's environment.
	Use #bindingOf: for looking up the variable binding in a full scope, including receiver's environment"

	"First look in classVar dictionary."
	(self classPool bindingOf: aSymbol) ifNotNil: [:binding | ^binding].
	"Next look in shared pools."
	self sharedPools do: [:pool | (pool bindingOf: aSymbol) ifNotNil: [:binding | ^binding]].
	self superclass ifNotNil: [:supercl | ^ supercl innerBindingOf: aSymbol].	
	^ nil
]

{ #category : #lookup }
RFiClass >> innerLookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	(self instVarNames includes: aName)
		ifTrue: [ ^ presentBlockClosure value: (self ringInstanceVariableNamed: aName) ].

	(self classVarNames includes: aName)
		ifTrue: [ ^ presentBlockClosure value: (self ringClassVariableNamed: aName) ].
		
	^ self superclass 
		ifNil: absentBlockClosure
		ifNotNil: [ :theSuperclass |
			theSuperclass
				innerLookupVariableNamed: aName 
				ifFound: presentBlockClosure 
				ifNotFound: absentBlockClosure ]
]

{ #category : #polymorphism }
RFiClass >> instVarNames [

	^ self instanceVariables
]

{ #category : #polymorphism }
RFiClass >> instanceVariables [

	^ ficusClass layout instanceVariables asArray
]

{ #category : #polymorphism }
RFiClass >> isMeta [

	^ false
]

{ #category : #polymorphism }
RFiClass >> localMethods [

	^ ficusClass methods collect: [ :aMethodShot | 
		self ringMethodFor: aMethodShot ]
]

{ #category : #polymorphism }
RFiClass >> lookupSelector: selector [

	| currentClass |
	currentClass := self.
	
	[ currentClass isNil ] whileFalse: [ 
		currentClass 
			compiledMethodAt: selector 
			ifPresent: [ :method | ^ method ]
			ifAbsent: [ ].

		currentClass := currentClass superclass ].
	^ nil
]

{ #category : #lookup }
RFiClass >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [
	"Answer the entity that declares a variable. Note this imitates the behavior of #bindingOf:"

	^ self 
		innerLookupVariableNamed: aName 
		ifFound: presentBlockClosure 
		ifNotFound: [
			self environment  
				lookupVariableNamed: aName 
				ifFound: presentBlockClosure 
				ifNotFound: absentBlockClosure ]
]

{ #category : #polymorphism }
RFiClass >> name [

	^ ficusClass name
]

{ #category : #polymorphism }
RFiClass >> parseTreeFor: aSymbol [

	^ self 
		compiledMethodAt: aSymbol 
		ifPresent: [ :method | method parseTree ]
		ifAbsent: [ nil ]
]

{ #category : #accessing }
RFiClass >> ringClassVariableNamed: aString [

	^ self ringClassVariables detect: [ :each | each name = aString ]
]

{ #category : #accessing }
RFiClass >> ringClassVariables [ 

	^ cachedClassVariables ifNil: [
		cachedClassVariables := self classVarNames collect: [ :each |
			RFiClassVariable definingClass: self name: each ] ]
]

{ #category : #polymorphism }
RFiClass >> sharedPoolNames [

	^ ficusClass sharedPools values
]

{ #category : #polymorphism }
RFiClass >> sharedPools [

	^ ficusClass sharedPools asArray sorted
		collect: [ :name | environment classNamed: name ]
]

{ #category : #polymorphism }
RFiClass >> sharedPoolsString [
	"Answer a string of my shared pool names separated by spaces."

	^ String streamContents: [ :stream |
		ficusClass sharedPools values
			do: [ :each | stream nextPutAll: each ]
			separatedBy: [ stream space ] ]
]

{ #category : #polymorphism }
RFiClass >> sourceCodeAt: selector ifAbsent: aBlock [

	^ self 
		compiledMethodAt: selector 
		ifPresent: [ :method | method sourceCode ] 
		ifAbsent: aBlock
]

{ #category : #polymorphism }
RFiClass >> subclasses [
	
	^ cachedSubclasses ifNil: [
		cachedSubclasses := 
			(environment allClasses
				select: [ :aClass | aClass ficusClass superclassName = self name ])
				asArray ]
]

{ #category : #polymorphism }
RFiClass >> subclassesDo: aBlock [
	"Evaluate the argument, aBlock, for each of the receiver's immediate subclasses."

	^ self subclasses do: aBlock
]

{ #category : #polymorphism }
RFiClass >> superclass [
	
	ficusClass hasNullSuperclass ifTrue: [ ^ nil ].
	
	^ cachedSuperclass ifNil: [
		cachedSuperclass := environment classNamed: ficusClass superclassName ]
]

{ #category : #polymorphism }
RFiClass >> theMetaClass [

	^ cachedMetaClass ifNil: [ 
		cachedMetaClass := RFiMetaclass new
			theNonMetaClass: self;
			yourself ]
]

{ #category : #polymorphism }
RFiClass >> theNonMetaClass [
	
	^ self
]

{ #category : #polymorphism }
RFiClass >> whichClassIncludesSelector: aSymbol [

	^ (self lookupSelector: aSymbol) 
		ifNil: [ nil ]
		ifNotNil: [ :method | method methodClass ]
]

{ #category : #polymorphism }
RFiClass >> withAllSubclasses [
	"Answer a Set of the receiver, the receiver's descendent's, and the  
	receiver's descendent's subclasses."

	^ self allSubclasses, { self }
]

{ #category : #polymorphism }
RFiClass >> withAllSuperAndSubclassesDo: aBlock [

	self allSuperclassesDo: aBlock.
	aBlock value: self.
	self allSubclassesDo: aBlock.
]

{ #category : #polymorphism }
RFiClass >> withAllSuperclasses [

	^ { self }, self allSuperclasses
]
