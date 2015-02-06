"
I am polymorphic with Class, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGClass,
	#superclass : #FiRGBehavior,
	#instVars : [
		'classShot',
		'environment',
		'cachedLocalMethods',
		'cachedSuperclass',
		'cachedMetaClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #comparing }
FiRGClass >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	self flag: #todo. "The == may be a wrong assumption"
	^ environment == other environment 
		and: [ classShot == other classShot ]
]

{ #category : #polymorphism }
FiRGClass >> allInstVarNames [

	^ classShot hasNullSuperclass
		ifTrue: [ self instVarNames ]
		ifFalse: [ self superclass allInstVarNames, self instVarNames ].

]

{ #category : #polymorphism }
FiRGClass >> allSelectors [
	"Answer all selectors understood by instances of the receiver"

	| result |
	result := IdentitySet new.

	self withAllSuperclasses do: [ :aClass | 
		result addAll: aClass selectors ].

	^ result
]

{ #category : #polymorphism }
FiRGClass >> allSubclasses [

	^ Array streamContents: [ :stream |
		self allSubclassesDo: [ :each | stream nextPut: each ] ]
]

{ #category : #polymorphism }
FiRGClass >> allSubclassesDo: aBlock [ 
	"Evaluate the argument, aBlock, for each of the receiver's subclasses."

	self subclassesDo: [ :aSubclass | 
		aBlock value: aSubclass.
		aSubclass allSubclassesDo: aBlock ]
]

{ #category : #polymorphism }
FiRGClass >> allSuperclasses [

	^ Array streamContents: [ :stream |
		self allSuperclassesDo: [ :each | stream nextPut: each ] ]
]

{ #category : #polymorphism }
FiRGClass >> allSuperclassesDo: aBlock [ 
	"Evaluate the argument, aBlock, for each of the receiver's superclasses."

	classShot hasNullSuperclass ifFalse: [
		aBlock value: self superclass.
		self superclass allSuperclassesDo: aBlock ]
]

{ #category : #converting }
FiRGClass >> asString [

	^ self name
]

{ #category : #polymorphism }
FiRGClass >> binding [
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
FiRGClass >> bindingOf: varName [
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
FiRGClass >> canUnderstand: aSymbol [

	self withAllSuperclasses do: [ :aClass |
		(aClass includesSelector: aSymbol) ifTrue: [ ^ true ] ].
	
	^ false
]

{ #category : #polymorphism }
FiRGClass >> category [

	^ classShot category
]

{ #category : #polymorphism }
FiRGClass >> classPool [

	^ classShot classPool 
		inject: Dictionary new
		into: [ :dictionary :each |
			dictionary 
				at: each put: nil;
				yourself ]
]

{ #category : #accessing }
FiRGClass >> classShot [
	
	^ classShot
]

{ #category : #accessing }
FiRGClass >> classShot: anObject [
	
	classShot := anObject
]

{ #category : #polymorphism }
FiRGClass >> classVarNames [

	^ classShot classPool values
]

{ #category : #polymorphism }
FiRGClass >> comment [

	^ classShot comment
]

{ #category : #polymorphism }
FiRGClass >> definition [
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
FiRGClass >> environment [
	
	^ environment
]

{ #category : #polymorphism }
FiRGClass >> environment: anObject [
	
	environment := anObject
]

{ #category : #polymorphism }
FiRGClass >> hasAbstractMethods [
	"Tells whether the receiver locally defines an abstract method, i.e., a method sending subclassResponsibility"
	^ super hasAbstractMethods or: [self class hasAbstractMethods]

]

{ #category : #polymorphism }
FiRGClass >> hasComment [
	
	^ classShot comment isNotEmpty
]

{ #category : #comparing }
FiRGClass >> hash [

	self flag: #todo. "The ==/identityHash may be a wrong assumption"

	^ (self class hash 
		bitXor: environment identityHash)
		bitXor: classShot identityHash
]

{ #category : #polymorphism }
FiRGClass >> innerBindingOf: aSymbol [
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
FiRGClass >> innerLookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	(self instVarNames includes: aName)
		ifTrue: [ ^ presentBlockClosure value: self ].

	(self classVarNames includes: aName)
		ifTrue: [ ^ presentBlockClosure value: self ].
		
	^ self superclass 
		ifNil: absentBlockClosure
		ifNotNil: [ :theSuperclass |
			theSuperclass
				innerLookupVariableNamed: aName 
				ifFound: presentBlockClosure 
				ifNotFound: absentBlockClosure ]
]

{ #category : #polymorphism }
FiRGClass >> instVarNames [

	^ self instanceVariables
]

{ #category : #polymorphism }
FiRGClass >> instanceVariables [

	^ classShot layout instanceVariables asArray
]

{ #category : #polymorphism }
FiRGClass >> isMeta [

	^ false
]

{ #category : #polymorphism }
FiRGClass >> localMethods [

	^ cachedLocalMethods ifNil: [
		cachedLocalMethods := classShot methods 
			collect: [ :aMethodShot | self ringMethodFor: aMethodShot ] ]
]

{ #category : #polymorphism }
FiRGClass >> lookupSelector: selector [

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
FiRGClass >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [
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
FiRGClass >> name [

	^ classShot theName
]

{ #category : #polymorphism }
FiRGClass >> parseTreeFor: aSymbol [

	^ self 
		compiledMethodAt: aSymbol 
		ifPresent: [ :method | method parseTree ]
		ifAbsent: [ nil ]
]

{ #category : #polymorphism }
FiRGClass >> sharedPoolNames [

	^ classShot sharedPools values
]

{ #category : #polymorphism }
FiRGClass >> sharedPools [

	^ classShot sharedPools asArray sorted
		collect: [ :name | environment classNamed: name ]
]

{ #category : #polymorphism }
FiRGClass >> sharedPoolsString [
	"Answer a string of my shared pool names separated by spaces."

	^ String streamContents: [ :stream |
		classShot sharedPools values
			do: [ :each | stream nextPutAll: each ]
			separatedBy: [ stream space ] ]
]

{ #category : #polymorphism }
FiRGClass >> sourceCodeAt: selector ifAbsent: aBlock [

	^ self 
		compiledMethodAt: selector 
		ifPresent: [ :method | method sourceCode ] 
		ifAbsent: aBlock
]

{ #category : #polymorphism }
FiRGClass >> subclasses [
	
	^ (environment allClasses
		select: [ :aClass | aClass classShot superclassName = self name ])
		asArray
]

{ #category : #polymorphism }
FiRGClass >> subclassesDo: aBlock [
	"Evaluate the argument, aBlock, for each of the receiver's immediate subclasses."

	^ self subclasses do: aBlock
]

{ #category : #polymorphism }
FiRGClass >> superclass [
	
	classShot hasNullSuperclass ifTrue: [ ^ nil ].
	
	^ cachedSuperclass ifNil: [
		cachedSuperclass := environment classNamed: classShot superclassName ]
]

{ #category : #polymorphism }
FiRGClass >> theMetaClass [

	^ cachedMetaClass ifNil: [ 
		cachedMetaClass := FiRGMetaclass new
			theNonMetaClass: self;
			yourself ]
]

{ #category : #polymorphism }
FiRGClass >> theNonMetaClass [
	
	^ self
]

{ #category : #polymorphism }
FiRGClass >> whichClassIncludesSelector: aSymbol [

	^ (self lookupSelector: aSymbol) 
		ifNil: [ nil ]
		ifNotNil: [ :method | method methodClass ]
]

{ #category : #polymorphism }
FiRGClass >> withAllSubclasses [
	"Answer a Set of the receiver, the receiver's descendent's, and the  
	receiver's descendent's subclasses."

	^ self allSubclasses, { self }
]

{ #category : #polymorphism }
FiRGClass >> withAllSuperAndSubclassesDo: aBlock [

	self allSuperclassesDo: aBlock.
	aBlock value: self.
	self allSubclassesDo: aBlock.
]

{ #category : #polymorphism }
FiRGClass >> withAllSuperclasses [

	^ { self }, self allSuperclasses
]
