"
I am polymorphic with Metaclass, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGMetaclass,
	#superclass : #FiRGBehavior,
	#instVars : [
		'theNonMetaClass'
	],
	#category : #'FicusRing-Core'
}

{ #category : #comparing }
FiRGMetaclass >> = other [

	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [ ^ false ].

	^ self theNonMetaClass = other theNonMetaClass
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

{ #category : #comparing }
FiRGMetaclass >> hash [

	^ self class hash bitXor: self theNonMetaClass hash
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
FiRGMetaclass >> methods [

	self flag: #fix.
	^ theNonMetaClass classShot metaclass methods values collect: [ :aMethodShot |
		self ringMethodFor: aMethodShot ]
]

{ #category : #polymorphism }
FiRGMetaclass >> name [

	^ theNonMetaClass name, ' class'
]

{ #category : #polymorphism }
FiRGMetaclass >> subclasses [
	
	^ self theNonMetaClass subclasses collect: #theMetaClass
]

{ #category : #polymorphism }
FiRGMetaclass >> theNonMetaClass [

	^ theNonMetaClass
]

{ #category : #accessing }
FiRGMetaclass >> theNonMetaClass: aFiRGClass [ 

	theNonMetaClass := aFiRGClass
]
