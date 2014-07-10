"
I am polymorphic with Class, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGClass,
	#superclass : #FiRGShot,
	#instVars : [
		'environment',
		'shot'
	],
	#category : #'FicusRing-Core'
}

{ #category : #comparing }
FiRGClass >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self environment = other environment 
		and: [ self shot = other shot ]
]

{ #category : #polymorphism }
FiRGClass >> >> selector [ 
	"Answer the compiled method associated with the argument, selector (a 
	Symbol), a message selector in the receiver's method dictionary. If the 
	selector is not in the dictionary, create an error notification."

	^ self compiledMethodAt: selector

]

{ #category : #polymorphism }
FiRGClass >> allInstVarNames [

	^ shot hasNullSuperclass
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

	shot hasNullSuperclass ifFalse: [
		aBlock value: self superclass.
		self superclass allSuperclassesDo: aBlock ]
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
FiRGClass >> classPool [

	^ shot classPool asDictionary
]

{ #category : #polymorphism }
FiRGClass >> classVarNames [

	^ shot classPool values
]

{ #category : #polymorphism }
FiRGClass >> comment [

	^ shot comment
]

{ #category : #polymorphism }
FiRGClass >> compiledMethodAt: selector [ 
	"Answer the compiled method associated with the argument, selector (a 
	Symbol), a message selector in the receiver's method dictionary. If the 
	selector is not in the dictionary, create an error notification."

	^ self methods detect: [ :aMethod | aMethod selector = selector ]
]

{ #category : #polymorphism }
FiRGClass >> compiledMethodAt: selector ifPresent: anotherBlock ifAbsent: aBlock [
	"Answer the compiled method associated with the argument, selector (a Symbol), a message selector in the receiver's method dictionary. If the selector is not in the dictionary, return the value of aBlock"

	^ self methods 
		detect: [ :aMethod | aMethod selector = selector ]
		ifFound: [ :aMethod | anotherBlock cull: aMethod ]
		ifNone: aBlock
]

{ #category : #polymorphism }
FiRGClass >> compiler [
	"Answer a compiler appropriate for source methods of this class."

	^ Smalltalk compilerClass new
		environment: self environment;
		class: self
]

{ #category : #polymorphism }
FiRGClass >> environment [
	
	^ environment
]

{ #category : #comparing }
FiRGClass >> hash [

	^ (self class hash 
		bitXor: self environment hash)
		bitXor: self shot hash
]

{ #category : #polymorphism }
FiRGClass >> includesSelector: aSymbol [ 
	"Answer whether the message whose selector is the argument is in the 
	method dictionary of the receiver's class."

	^ self
		compiledMethodAt: aSymbol
		ifPresent: [ :method | true ]
		ifAbsent: [ false ].
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

{ #category : #polymorphism }
FiRGClass >> instVarNames [

	^ self shot layout slotNames values asArray
]

{ #category : #polymorphism }
FiRGClass >> isBehavior [

	^ true
]

{ #category : #polymorphism }
FiRGClass >> isMeta [

	^ false
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

	(self instVarNames includes: aName)
		ifTrue: [ ^ presentBlockClosure value: self ].
		
	^ (self superclass ifNil: [ self environment ])
		lookupVariableNamed: aName 
		ifFound: presentBlockClosure 
		ifNotFound: absentBlockClosure
]

{ #category : #polymorphism }
FiRGClass >> methods [
	
	"FIX"
	^ shot methods values collect: [ :aMethodShot |
		self ringMethodFor: aMethodShot ]
]

{ #category : #accessing }
FiRGClass >> name [

	^ self shot theName
]

{ #category : #polymorphism }
FiRGClass >> parseTreeFor: aSymbol [

	^ self 
		compiledMethodAt: aSymbol 
		ifPresent: [ :method | method parseTree ]
		ifAbsent: [ nil ]
]

{ #category : #printing }
FiRGClass >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $).
	
]

{ #category : #accessing }
FiRGClass >> ringEnvironment: anObject [
	
	environment := anObject
]

{ #category : #private }
FiRGClass >> ringMethodFor: aMethodShot [

	^ FiRGMethod new 
		ringEnvironment: environment; 
		ringMethodClass: self;
		shot: aMethodShot;
		yourself
]

{ #category : #polymorphism }
FiRGClass >> selectors [

	^ self methods collect: #selector
]

{ #category : #polymorphism }
FiRGClass >> selectorsAndMethodsDo: selectorAndMethodBlock [
	"Evaluate selectorAndMethodBlock with two arguments for each selector/method pair in my method dictionary."

	^ self methods do: [ :each | 
		selectorAndMethodBlock value: each selector value: each ]
]

{ #category : #polymorphism }
FiRGClass >> sharedPoolNames [

	^ shot sharedPools values
]

{ #category : #polymorphism }
FiRGClass >> sharedPools [

	^ shot sharedPools asArray
]

{ #category : #accessing }
FiRGClass >> shot [
	
	^ shot
]

{ #category : #accessing }
FiRGClass >> shot: anObject [
	
	shot := anObject
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
	
	^ environment allClasses select: [ :aClass | aClass shot superclassName = self name ]
]

{ #category : #polymorphism }
FiRGClass >> subclassesDo: aBlock [
	"Evaluate the argument, aBlock, for each of the receiver's immediate subclasses."

	^ self subclasses do: aBlock
]

{ #category : #polymorphism }
FiRGClass >> superclass [
	
	shot hasNullSuperclass ifTrue: [ ^ nil ].
	
	^ environment classNamed: shot superclassName
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
