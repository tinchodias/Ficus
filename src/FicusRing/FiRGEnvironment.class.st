"
I am polymorphic with SystemDictionary, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGEnvironment,
	#superclass : #FiRGObject,
	#instVars : [
		'packagesShot',
		'allClasses'
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

	allClasses ifNotNil: [ ^ allClasses ].

	^ allClasses := 
		Array streamContents: [ :stream |
			packagesShot valuesDo: [ :packageShot |
				stream nextPutAll: 
					(packageShot contents values 
						select: #isFicusClass 
						thenCollect: [ :classShot |
							FiRGClass new 
								environment: self; 
								classShot: classShot;
								yourself ]) ] ]
]

{ #category : #polymorphism }
FiRGEnvironment >> allClassesAndTraits [

	"FIX"
	^ self allClasses
]

{ #category : #private }
FiRGEnvironment >> allClassesAndTraitsDo: aBlockClosure [ 

	^ self allClassesAndTraits do: aBlockClosure 
]

{ #category : #private }
FiRGEnvironment >> allClassesDo: aBlockClosure [ 

	^ self allClasses do: aBlockClosure 
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

	^ self allClasses 
		detect: [ :aFiRGClass | aFiRGClass name = aName ]
		ifFound: presentBlock
		ifNone: absentBlock

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
	
	^ self at: aName ifAbsent: [ NotFound signal ]
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
FiRGEnvironment >> extensionMethodsFor: aBehavior [
	
	^ packagesShot values 
		flatCollect: [ :aPackageShot |
			(aPackageShot contents values
				select: [ :each |
					each isFicusExtensionMethods and: [ 
					each hostName = aBehavior name and: [ 
					each isMetaSide = aBehavior isMeta ] ] ])
				flatCollect: [ :each |
					each methods collect: [ :eachMethod | 
						aBehavior ringMethodFor: eachMethod ] ] ]
]

{ #category : #polymorphism }
FiRGEnvironment >> hasBindingThatBeginsWith: aString [ 

	^ self allClassesAndTraits anySatisfy: [ :each | each name beginsWith: aString ]
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
				ifAbsent: [ ] ] ]
]

{ #category : #lookup }
FiRGEnvironment >> implementorsOf: aSelector inHierarchyOf: aRingClass [

	^ Array streamContents: [ :stream |
		aRingClass withAllSuperAndSubclassesDo: [ :aClassOrTrait |
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

{ #category : #lookup }
FiRGEnvironment >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	^ self 
		at: aName 
		ifPresent: presentBlockClosure 
		ifAbsent: absentBlockClosure
]
