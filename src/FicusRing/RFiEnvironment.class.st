"
I am polymorphic with SystemDictionary, fetching everything needed from a Ficus environment.
"
Class {
	#name : #RFiEnvironment,
	#superclass : #RFiObject,
	#instVars : [
		'ficusPackages',
		'allClasses',
		'packageByClassName',
		'extensionMethodsByBehaviorName',
		'globalByName',
		'cachedImplementorsBySelector',
		'cachedPackages'
	],
	#category : #'FicusRing-Core'
}

{ #category : #'instance creation' }
RFiEnvironment class >> ficusPackages: aFiSet [

	^ self basicNew
		initializeWithFicusPackages: aFiSet;
		yourself
]

{ #category : #comparing }
RFiEnvironment >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self ficusPackages = other ficusPackages
]

{ #category : #polymorphism }
RFiEnvironment >> allClasses [

	^ allClasses ifNil: [ 
		allClasses := self packages 
			flatCollect: [ :package | package definedClasses ] ]
]

{ #category : #polymorphism }
RFiEnvironment >> allClassesAndTraits [

	self flag: #todo. "FIX"
	^ self allClasses
]

{ #category : #polymorphism }
RFiEnvironment >> allClassesAndTraitsDo: aBlockClosure [ 

	^ self allClassesAndTraits do: aBlockClosure 
]

{ #category : #polymorphism }
RFiEnvironment >> allClassesDo: aBlockClosure [ 

	^ self allClasses do: aBlockClosure 
]

{ #category : #iterating }
RFiEnvironment >> allTraitsDo: aBlockClosure [ 
	
	self flag: #todo.
	^ self
]

{ #category : #polymorphism }
RFiEnvironment >> associationAt: key [

	^ self 
		associationAt: key 
		ifAbsent: [ NotFound signalFor: key in: self ]
]

{ #category : #polymorphism }
RFiEnvironment >> associationAt: key ifAbsent: aBlock [ 

	^ (self 
		at: key 
		ifAbsent: [ ^ aBlock value ])
		in: [ :found | key -> found ]
]

{ #category : #polymorphism }
RFiEnvironment >> at: aName ifAbsent: aBlockClosure [ 

	^ self 
		at: aName 
		ifPresent: [ :value | value ]
		ifAbsent: aBlockClosure
]

{ #category : #polymorphism }
RFiEnvironment >> at: aName ifPresent: presentBlock ifAbsent: absentBlock [

	^ self globalByName
		at: aName 
		ifPresent: presentBlock 
		ifAbsent: absentBlock
]

{ #category : #polymorphism }
RFiEnvironment >> bindingOf: aName [
	
	^ self 
		at: aName
		ifPresent: [ :value | aName -> value ]
		ifAbsent: [ nil ]
]

{ #category : #ui }
RFiEnvironment >> browse [

	^ RFiEnvironmentBrowser openOn: self 
]

{ #category : #polymorphism }
RFiEnvironment >> classNamed: aName [
	
	self flag: #todo. "What if it's not a class?"
	^ self at: aName ifAbsent: [ NotFound signalFor: aName in: self ]
]

{ #category : #lookup }
RFiEnvironment >> extensionMethodsByBehaviorName [
	
	self flag: #todo. "ugly"
	
	extensionMethodsByBehaviorName ifNil: [
		extensionMethodsByBehaviorName := Dictionary new.

		ficusPackages do: [ :aPackageShot |
			aPackageShot extensionMethods do: [ :anExtensionMethodsShot |
				anExtensionMethodsShot methods collect: [ :aMethodShot | 
					self 
						at: anExtensionMethodsShot hostName
						ifPresent: [ :aBehavior |
							| finalBehavior |
							finalBehavior := anExtensionMethodsShot isMetaSide 
								ifTrue: [ aBehavior classSide ]
								ifFalse: [ aBehavior ].

							(extensionMethodsByBehaviorName 
								at: anExtensionMethodsShot hostName 
								ifAbsentPut: [ Set new ])
								add: (finalBehavior ringMethodFor: aMethodShot) ]
						ifAbsent: []
				]]]].

	^ extensionMethodsByBehaviorName
]

{ #category : #lookup }
RFiEnvironment >> extensionMethodsFor: aBehavior [
	
	^ (self extensionMethodsByBehaviorName
		at: aBehavior theNonMetaClass name 
		ifAbsent: [ ^ #() ]) 
		select: [:aMethod | aMethod methodClass = aBehavior ]
]

{ #category : #accessing }
RFiEnvironment >> ficusPackages [
	
	^ ficusPackages
]

{ #category : #accessing }
RFiEnvironment >> ficusPathToClass: aFiRGClass [ 
	
	^ {aFiRGClass package name. #contents. aFiRGClass name} asFiPath
]

{ #category : #accessing }
RFiEnvironment >> ficusPathToInstanceVariable: aFiRGInstanceVariable [ 

	^ aFiRGInstanceVariable definingClass ficusPathFromEnvironment / 
		#layout / #instanceVariables / aFiRGInstanceVariable name
]

{ #category : #accessing }
RFiEnvironment >> ficusPathToMethod: aFiRGMethod [ 

	^ aFiRGMethod origin ficusPathFromEnvironment / #methods / aFiRGMethod selector
]

{ #category : #accessing }
RFiEnvironment >> ficusRGObjectFromPath: aFiPath [
	
	| steps |
	self flag: #todo. "FIX..."
	
	steps := aFiPath steps.
	
	steps size < 4 ifTrue: [ self notYetImplemented  ].
	
	steps fourth = #methods ifTrue: [ 
		^ (self classNamed: steps third) >> steps fifth ].

	steps fourth = #layout ifTrue: [ 
		^ self classNamed: steps third ].

	steps fourth = #metaclass ifTrue: [ 
		^ (self classNamed: steps third) theMetaClass ].
	
	self notYetImplemented 
]

{ #category : #accessing }
RFiEnvironment >> globalByName [

	^ globalByName ifNil: [
		globalByName := Dictionary new.

		self allClassesAndTraits do: [ :aClassOrTrait |
			globalByName 
				at: aClassOrTrait name
				put: aClassOrTrait ].

		self knownGlobalNames do: [ :aGlobalName |
			globalByName 
				at: aGlobalName
				put: self knownGlobalDummyValue ].
			
		globalByName ]
]

{ #category : #polymorphism }
RFiEnvironment >> hasBindingThatBeginsWith: aString [ 

	^ (self allClassesAndTraits 
		anySatisfy: [ :each | each name beginsWith: aString ])
		or: [ self knownGlobalNames 
			anySatisfy: [ :each | each beginsWith: aString ]]
]

{ #category : #comparing }
RFiEnvironment >> hash [

	^ self class hash 
		bitXor: self ficusPackages hash
]

{ #category : #lookup }
RFiEnvironment >> implementorsOf: aSelector [ 
	
	cachedImplementorsBySelector ifNil: [
		cachedImplementorsBySelector := Dictionary new.
		
		self allClassesAndTraitsDo: [ :aClassOrTrait |
			|block |
			block := [ :method |
				(cachedImplementorsBySelector 
					at: method selector
					ifAbsentPut: [ OrderedCollection new ]) 
					add: method ].
			aClassOrTrait methods do: block.
			aClassOrTrait classSide methods do: block.
			] ].
		
	^ cachedImplementorsBySelector 
		at: aSelector
		ifAbsent: [ #() ]
]

{ #category : #lookup }
RFiEnvironment >> implementorsOf: aSelector inHierarchyOf: aRingClass [

	^ Array streamContents: [ :stream |
		aRingClass
			compiledMethodAt: aSelector 
			ifPresent: [ :method | stream nextPut: method ]
			ifAbsent: [
				self 
					lookupImplementorOf: aSelector 
					inSuperclassesOf: aRingClass 
					ifPresent: [ :method | stream nextPut: method ]
					ifAbsent: [] ].
				
		aRingClass allSubclassesDo: [ :aClassOrTrait |
			aClassOrTrait 
				compiledMethodAt: aSelector 
				ifPresent: [ :method | stream nextPut: method ] 
				ifAbsent: [ ] ] ]
]

{ #category : #lookup }
RFiEnvironment >> implementorsOf: aSelector inSuperclassesOf: aRingClass [ 

	^ Array streamContents: [ :stream |
		aRingClass allSuperclassesDo: [ :aClass |
			aClass
				compiledMethodAt: aSelector 
				ifPresent: [ :method | stream nextPut: method ] 
				ifAbsent: [ ] ] ]
]

{ #category : #initialization }
RFiEnvironment >> initializeWithFicusPackages: aFiSet [

	self initialize.
	
	ficusPackages := aFiSet.
]

{ #category : #accessing }
RFiEnvironment >> knownGlobalDummyValue [

	^ #dummyValue
]

{ #category : #accessing }
RFiEnvironment >> knownGlobalNames [
	
	^ #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #ActiveWorld #ActiveHand #ActiveEvent #Sensor #Processor #SystemOrganization #World)
]

{ #category : #lookup }
RFiEnvironment >> lookupImplementorOf: aSelector inHierarchyOf: aRingClass ifPresent: presentBlock ifAbsent: absentBlock [

	aRingClass withAllSuperAndSubclassesDo: [ :aClassOrTrait |
		aClassOrTrait 
			compiledMethodAt: aSelector 
			ifPresent: [ :method | ^ presentBlock cull: method ] 
			ifAbsent: [ ] ].
		
	^ absentBlock value
]

{ #category : #lookup }
RFiEnvironment >> lookupImplementorOf: aSelector inSuperclassesOf: aRingClass ifPresent: presentBlock ifAbsent: absentBlock [

	aRingClass allSuperclassesDo: [ :aClass |
		aClass
			compiledMethodAt: aSelector 
			ifPresent: [ :method | ^ presentBlock cull: method ] 
			ifAbsent: [ ] ].

	^ absentBlock value
]

{ #category : #lookup }
RFiEnvironment >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	^ self 
		at: aName 
		ifPresent: presentBlockClosure 
		ifAbsent: absentBlockClosure
]

{ #category : #accessing }
RFiEnvironment >> packageByClassName [
	
	^ packageByClassName ifNil: [
		packageByClassName := Dictionary new.

		self packages do: [ :package | 
			package definedClasses do: [ :aClass |
				packageByClassName
					at: aClass name 
					put: package ]].
			
		packageByClassName ]
]

{ #category : #accessing }
RFiEnvironment >> packageOfClass: aFiRGClass [ 

	^ self packageOfClassNamed: aFiRGClass name
]

{ #category : #accessing }
RFiEnvironment >> packageOfClassNamed: aName [ 
	
	^ self packageByClassName 
		at: aName 
		ifAbsent: [ self notYetImplemented ]
]

{ #category : #accessing }
RFiEnvironment >> packages [
	
	^ cachedPackages ifNil: [
		cachedPackages := ficusPackages collect: [ :each | self ringPackageFor: each ] ]
]

{ #category : #private }
RFiEnvironment >> ringClassFor: aFiClass [

	^ RFiClass
		environment: self
		ficusClass: aFiClass
]

{ #category : #private }
RFiEnvironment >> ringPackageFor: aFiPackage [ 
	
	^ RFiPackage 
		environment: self
		ficusPackage: aFiPackage
]
