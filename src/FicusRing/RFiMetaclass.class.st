"
I am polymorphic with Metaclass, fetching everything needed from a Ficus environment.
"
Class {
	#name : #RFiMetaclass,
	#superclass : #RFiBehavior,
	#instVars : [
		'theNonMetaClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #comparing }
RFiMetaclass >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self theNonMetaClass = other theNonMetaClass
]

{ #category : #converting }
RFiMetaclass >> asString [

	^ self name
]

{ #category : #polymorphism }
RFiMetaclass >> bindingOf: varName [

	^ self theNonMetaClass classBindingOf: varName
]

{ #category : #polymorphism }
RFiMetaclass >> definition [
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
RFiMetaclass >> environment [

	^ theNonMetaClass environment
]

{ #category : #accessing }
RFiMetaclass >> ficusPathFromEnvironment [

	^ theNonMetaClass ficusPathFromEnvironment / #metaclass
]

{ #category : #comparing }
RFiMetaclass >> hash [

	^ self class hash bitXor: self theNonMetaClass hash
]

{ #category : #lookup }
RFiMetaclass >> innerLookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [

	(self instVarNames includes: aName)
		ifTrue: [ ^ presentBlockClosure value: (self ringInstanceVariableNamed: aName) ].
		
	^ self superclass 
		ifNil: absentBlockClosure
		ifNotNil: [ :theSuperclass |
			theSuperclass
				innerLookupVariableNamed: aName 
				ifFound: presentBlockClosure 
				ifNotFound: absentBlockClosure ]
]

{ #category : #polymorphism }
RFiMetaclass >> instanceVariables [

	self flag: #fix.
	^ theNonMetaClass ficusClass metaclass layout instanceVariables asArray
]

{ #category : #polymorphism }
RFiMetaclass >> isMeta [

	^ true
]

{ #category : #polymorphism }
RFiMetaclass >> localMethods [

	^ self theNonMetaClass ficusClass metaclass methods values 
		collect: [ :aMethodShot | self ringMethodFor: aMethodShot ]
]

{ #category : #lookup }
RFiMetaclass >> lookupVariableNamed: aName ifFound: presentBlockClosure ifNotFound: absentBlockClosure [
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
RFiMetaclass >> name [

	^ theNonMetaClass name, ' class'
]

{ #category : #polymorphism }
RFiMetaclass >> soleInstance [
	
	^ theNonMetaClass
]

{ #category : #polymorphism }
RFiMetaclass >> subclasses [
	
	^ self theNonMetaClass subclasses collect: #theMetaClass
]

{ #category : #polymorphism }
RFiMetaclass >> superclass [
	
	^ theNonMetaClass superclass 
		ifNil: [ self environment classNamed: #Class ]
		ifNotNil: [ :superclass | superclass theMetaClass ]
]

{ #category : #polymorphism }
RFiMetaclass >> theNonMetaClass [

	^ theNonMetaClass
]

{ #category : #accessing }
RFiMetaclass >> theNonMetaClass: aRFiClass [ 

	self flag: #todo. "remove debugging code"
	self assert: (aRFiClass isKindOf: RFiClass).

	theNonMetaClass := aRFiClass
]
