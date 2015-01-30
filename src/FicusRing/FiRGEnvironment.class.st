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
		'packages'
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

{ #category : #'as yet unclassified' }
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

	^ self allClassesAndTraits
		detect: [ :aClassOrTrait | aClassOrTrait name = aName ]
		ifFound: presentBlock
		ifNone: [ self knownGlobalNames 
			detect: [ :each | each = aName ] 
			ifFound: [ presentBlock cull: self knownGlobalDummyValue ]
			ifNone: absentBlock ]
]

{ #category : #polymorphism }
FiRGEnvironment >> bindingOf: aName [
	
	^ self 
		at: aName
		ifPresent: [ :value | aName -> value ]
		ifAbsent: [ nil ]
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
	
	"lazy and ugly initialization"
	extensionMethodsByBehaviorName ifNil: [
		extensionMethodsByBehaviorName := Dictionary new.

		packagesShot do: [ :aPackageShot |
			aPackageShot extensionMethods do: [ :anExtensionMethodsShot |
				anExtensionMethodsShot methods collect: [ :aMethodShot | 
					self 
						at: anExtensionMethodsShot hostName
						ifPresent: [ :aBehavior |
							(extensionMethodsByBehaviorName 
								at: anExtensionMethodsShot hostName 
								ifAbsentPut: [ Set new ])
								add: (aBehavior ringMethodFor: aMethodShot) ]
						ifAbsent: []
				]]]].

	^ extensionMethodsByBehaviorName
]

{ #category : #lookup }
FiRGEnvironment >> extensionMethodsFor: aBehavior [
	
	^ (self extensionMethodsByBehaviorName
		at: aBehavior name 
		ifAbsent: [ ^ #() ]) 
		select: [:aMethod | aMethod methodClass = aBehavior ]
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
	
	^ Array streamContents: [ :stream |
		self allClassesAndTraitsDo: [ :aClassOrTrait |
			aClassOrTrait 
				compiledMethodAt: aSelector 
				ifPresent: [ :method | stream nextPut: method ] 
				ifAbsent: [ ].
			aClassOrTrait classSide
				compiledMethodAt: aSelector 
				ifPresent: [ :method | stream nextPut: method ] 
				ifAbsent: [ ] ] ]
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

{ #category : #initialization }
FiRGEnvironment >> initialize [

	super initialize.
	
	packageByClassName := Dictionary new.
]

{ #category : #accessing }
FiRGEnvironment >> knownGlobalDummyValue [

	^ #dummyValue
]

{ #category : #accessing }
FiRGEnvironment >> knownGlobalNames [
	
	^ #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #TextConstants #ActiveWorld #ActiveHand #ActiveEvent #Sensor #Processor #SystemOrganization #World)
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
FiRGEnvironment >> packageOfClass: aFiRGClass [ 

	^ self packageOfClassNamed: aFiRGClass name
]

{ #category : #accessing }
FiRGEnvironment >> packageOfClassNamed: aName [ 
	
	^ packageByClassName at: aName ifAbsentPut: [
		self packages 
			detect: [ :each | each definedClasses 
				anySatisfy: [ :aClass | aClass name = aName ]]]
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
