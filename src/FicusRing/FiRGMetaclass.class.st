"
I am polymorphic with Metaclass, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGMetaclass,
	#superclass : #FiRGBehavior,
	#instVars : [
		'theNonMetaClass',
		'cachedLocalMethods'
	],
	#category : #'FicusRing-Core'
}

{ #category : #comparing }
FiRGMetaclass >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self theNonMetaClass = other theNonMetaClass
]

{ #category : #converting }
FiRGMetaclass >> asString [

	^ self name
]

{ #category : #polymorphism }
FiRGMetaclass >> bindingOf: varName [

	^ self theNonMetaClass classBindingOf: varName
]

{ #category : #polymorphism }
FiRGMetaclass >> definition [
	"Refer to the comment in ClassDescription|definition."

	^ String streamContents: 
		[:strm |
		strm nextPutAll: self name.
		(self hasTraitComposition and: [self traitComposition notEmpty]) ifTrue: [
			strm
				crtab;
				nextPutAll: 'uses: ';
				print: self traitComposition ].
		strm
			crtab;
			nextPutAll: 'instanceVariableNames: ';
			store: self instanceVariablesString]
]

{ #category : #polymorphism }
FiRGMetaclass >> environment [

	^ theNonMetaClass environment
]

{ #category : #accessing }
FiRGMetaclass >> ficusPathFromEnvironment [

	^ theNonMetaClass ficusPathFromEnvironment / #metaclass
]

{ #category : #comparing }
FiRGMetaclass >> hash [

	^ self class hash bitXor: self theNonMetaClass hash
]

{ #category : #lookup }
FiRGMetaclass >> innerLookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	(self instVarNames includes: aName)
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
FiRGMetaclass >> instanceVariables [

	self flag: #fix.
	^ theNonMetaClass classShot metaclass layout instanceVariables asArray
]

{ #category : #polymorphism }
FiRGMetaclass >> isMeta [

	^ true
]

{ #category : #polymorphism }
FiRGMetaclass >> localMethods [

	^ cachedLocalMethods ifNil: [
		cachedLocalMethods := self theNonMetaClass classShot metaclass methods values 
			collect: [ :aMethodShot | self ringMethodFor: aMethodShot ] ]
]

{ #category : #lookup }
FiRGMetaclass >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [
	"Answer the entity that declares a variable. Note this imitates the behavior of #bindingOf:"

	^ self 
		innerLookupVariableNamed: aName 
		ifFound: presentBlockClosure 
		ifNotFound: [
			self theNonMetaClass
				lookupVariableNamed: aName 
				ifFound: presentBlockClosure 
				ifNotFound: absentBlockClosure ]
]

{ #category : #polymorphism }
FiRGMetaclass >> name [

	^ theNonMetaClass name, ' class'
]

{ #category : #polymorphism }
FiRGMetaclass >> soleInstance [
	
	^ theNonMetaClass
]

{ #category : #polymorphism }
FiRGMetaclass >> subclasses [
	
	^ self theNonMetaClass subclasses collect: #theMetaClass
]

{ #category : #polymorphism }
FiRGMetaclass >> superclass [
	
	^ theNonMetaClass superclass 
		ifNil: [ self environment classNamed: #Class ]
		ifNotNil: [ :superclass | superclass theMetaClass ]
]

{ #category : #polymorphism }
FiRGMetaclass >> theNonMetaClass [

	^ theNonMetaClass
]

{ #category : #accessing }
FiRGMetaclass >> theNonMetaClass: aFiRGClass [ 

	self flag: #todo. "remove debugging code"
	self assert: (aFiRGClass isKindOf: FiRGClass).

	theNonMetaClass := aFiRGClass
]
