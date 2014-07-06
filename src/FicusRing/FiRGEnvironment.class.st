"
I am polymorphic with SystemDictionary, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGEnvironment,
	#superclass : #FiRGShot,
	#instVars : [
		'packagesShot'
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

	^ Array streamContents: [ :stream |
		packagesShot 
			valuesDo: [ :packageShot |
				stream nextPutAll: 
					(packageShot contents values 
						select: #isFicusClass 
						thenCollect: [ :classShot |
							FiRGClass new 
								ringEnvironment: self; 
								shot: classShot;
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

{ #category : #polymorphism }
FiRGEnvironment >> at: aName ifAbsent: aBlockClosure [ 

	^ self 
		at: aName 
		ifPresent: [ :value | value ]
		ifAbsent: aBlockClosure
]

{ #category : #polymorphism }
FiRGEnvironment >> at: aName ifPresent: presentBlock ifAbsent: absentBlock [

	self allClasses 
		detect: [ :aPClass | aPClass name = aName ]
		ifFound: [ :aPClass | ^ presentBlock cull: aPClass ]
		ifNone: [ ^ absentBlock value ]

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
