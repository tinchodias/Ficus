"
I am polymorphic with SystemDictionary, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGEnvironment,
	#superclass : #FiRGObject,
	#instVars : [
		'packagesShot',
		'allClasses',
		'packageByClassName',
		'extensionMethodsByBehaviorName',
		'packages',
		'globalByName',
		'cachedImplementorsBySelector'
	],
	#category : #'FicusRing-Core'
}

{ #category : #comparing }
FiRGEnvironment >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self environmentShot = other environmentShot
]

{ #category : #polymorphism }
FiRGEnvironment >> allClasses [

	^ allClasses ifNil: [ 
		allClasses := self packages 
			flatCollect: [ :package | package definedClasses ] ]
]

{ #category : #polymorphism }
FiRGEnvironment >> allClassesAndTraits [

	self flag: #todo. "FIX"
	^ self allClasses
]

{ #category : #polymorphism }
FiRGEnvironment >> allClassesAndTraitsDo: aBlockClosure [ 

	^ self allClassesAndTraits do: aBlockClosure 
]

{ #category : #polymorphism }
FiRGEnvironment >> allClassesDo: aBlockClosure [ 

	^ self allClasses do: aBlockClosure 
]

{ #category : #iterating }
FiRGEnvironment >> allTraitsDo: aBlockClosure [ 
	
	self flag: #todo.
	^ self
]

{ #category : #polymorphism }
FiRGEnvironment >> associationAt: key [

	^ self 
		associationAt: key 
		ifAbsent: [ NotFound signalFor: key in: self ]
]

{ #category : #polymorphism }
FiRGEnvironment >> associationAt: key ifAbsent: aBlock [ 

	^ (self 
		at: key 
		ifAbsent: [ ^ aBlock value ])
		in: [ :found | key -> found ]
]

{ #category : #polymorphism }
FiRGEnvironment >> at: aName ifAbsent: aBlockClosure [ 

	^ self 
		at: aName 
		ifPresent: [ :value | value ]
		ifAbsent: aBlockClosure
]

{ #category : #polymorphism }
FiRGEnvironment >> at: aName ifPresent: presentBlock ifAbsent: absentBlock [

	^ self globalByName
		at: aName 
		ifPresent: presentBlock 
		ifAbsent: absentBlock
]

{ #category : #polymorphism }
FiRGEnvironment >> bindingOf: aName [
	
	^ self 
		at: aName
		ifPresent: [ :value | aName -> value ]
		ifAbsent: [ nil ]
]

{ #category : #ui }
FiRGEnvironment >> browse [

	^ FiRGEnvironmentBrowser openOn: self 
]

{ #category : #polymorphism }
FiRGEnvironment >> classNamed: aName [
	
	self flag: #todo. "What if it's not a class?"
	^ self at: aName ifAbsent: [ NotFound signalFor: aName in: self ]
]

{ #category : #accessing }
FiRGEnvironment >> environmentShot [
	
	^ packagesShot
]

{ #category : #accessing }
FiRGEnvironment >> environmentShot: anObject [
	
	packagesShot := anObject
]

{ #category : #lookup }
FiRGEnvironment >> extensionMethodsByBehaviorName [
	
	self flag: #todo. "ugly"
	
	extensionMethodsByBehaviorName ifNil: [
		extensionMethodsByBehaviorName := Dictionary new.

		packagesShot do: [ :aPackageShot |
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
FiRGEnvironment >> extensionMethodsFor: aBehavior [
	
	^ (self extensionMethodsByBehaviorName
		at: aBehavior theNonMetaClass name 
		ifAbsent: [ ^ #() ]) 
		select: [:aMethod | aMethod methodClass = aBehavior ]
]

{ #category : #accessing }
FiRGEnvironment >> ficusPathToClass: aFiRGClass [ 
	
	^ {aFiRGClass package name. #contents. aFiRGClass name} asFiPath
]

{ #category : #accessing }
FiRGEnvironment >> ficusPathToInstanceVariable: aFiRGInstanceVariable [ 

	^ aFiRGInstanceVariable definingClass ficusPathFromEnvironment / 
		#layout / #instanceVariables / aFiRGInstanceVariable name
]

{ #category : #accessing }
FiRGEnvironment >> ficusPathToMethod: aFiRGMethod [ 

	^ aFiRGMethod origin ficusPathFromEnvironment / #methods / aFiRGMethod selector
]

{ #category : #accessing }
FiRGEnvironment >> ficusRGObjectFromPath: aFiPath [
	
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
FiRGEnvironment >> globalByName [

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
FiRGEnvironment >> hasBindingThatBeginsWith: aString [ 

	^ (self allClassesAndTraits 
		anySatisfy: [ :each | each name beginsWith: aString ])
		or: [ self knownGlobalNames 
			anySatisfy: [ :each | each beginsWith: aString ]]
]

{ #category : #comparing }
FiRGEnvironment >> hash [

	^ self class hash 
		bitXor: self environmentShot hash
]

{ #category : #lookup }
FiRGEnvironment >> implementorsOf: aSelector [ 
	
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
FiRGEnvironment >> implementorsOf: aSelector inHierarchyOf: aRingClass [

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
FiRGEnvironment >> implementorsOf: aSelector inSuperclassesOf: aRingClass [ 

	^ Array streamContents: [ :stream |
		aRingClass allSuperclassesDo: [ :aClass |
			aClass
				compiledMethodAt: aSelector 
				ifPresent: [ :method | stream nextPut: method ] 
				ifAbsent: [ ] ] ]
]

{ #category : #accessing }
FiRGEnvironment >> knownGlobalDummyValue [

	^ #dummyValue
]

{ #category : #accessing }
FiRGEnvironment >> knownGlobalNames [
	
	^ #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #ActiveWorld #ActiveHand #ActiveEvent #Sensor #Processor #SystemOrganization #World)
]

{ #category : #lookup }
FiRGEnvironment >> lookupImplementorOf: aSelector inHierarchyOf: aRingClass ifPresent: presentBlock ifAbsent: absentBlock [

	aRingClass withAllSuperAndSubclassesDo: [ :aClassOrTrait |
		aClassOrTrait 
			compiledMethodAt: aSelector 
			ifPresent: [ :method | ^ presentBlock cull: method ] 
			ifAbsent: [ ] ].
		
	^ absentBlock value
]

{ #category : #lookup }
FiRGEnvironment >> lookupImplementorOf: aSelector inSuperclassesOf: aRingClass ifPresent: presentBlock ifAbsent: absentBlock [

	aRingClass allSuperclassesDo: [ :aClass |
		aClass
			compiledMethodAt: aSelector 
			ifPresent: [ :method | ^ presentBlock cull: method ] 
			ifAbsent: [ ] ].

	^ absentBlock value
]

{ #category : #lookup }
FiRGEnvironment >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	^ self 
		at: aName 
		ifPresent: presentBlockClosure 
		ifAbsent: absentBlockClosure
]

{ #category : #accessing }
FiRGEnvironment >> packageByClassName [
	
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
FiRGEnvironment >> packageOfClass: aFiRGClass [ 

	^ self packageOfClassNamed: aFiRGClass name
]

{ #category : #accessing }
FiRGEnvironment >> packageOfClassNamed: aName [ 
	
	^ self packageByClassName 
		at: aName 
		ifAbsent: [ self notYetImplemented ]
]

{ #category : #accessing }
FiRGEnvironment >> packages [
	
	^ packages ifNil: [
		packages := packagesShot collect: [ :each | self ringPackageFor: each ] ]
]

{ #category : #private }
FiRGEnvironment >> ringClassFor: classShot [

	^ FiRGClass new 
		environment: self; 
		classShot: classShot;
		yourself
]

{ #category : #private }
FiRGEnvironment >> ringPackageFor: aFiPackage [ 
	
	^ FiRGPackage new 
		environment: self;
		packageShot: aFiPackage;
		yourself
]
