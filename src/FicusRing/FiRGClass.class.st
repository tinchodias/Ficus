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

	^ shot superclass isNil
		ifTrue: [ self instVarNames ]
		ifFalse: [ self superclass allInstVarNames, self instVarNames ].

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
FiRGClass >> instVarNames [

	^ self shot layout slotNames values asArray
]

{ #category : #polymorphism }
FiRGClass >> isBehavior [

	^ true
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
FiRGClass >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(.
	self name printOn: aStream.
	aStream nextPut: $).

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

{ #category : #accessing }
FiRGClass >> shot [
	
	^ shot
]

{ #category : #accessing }
FiRGClass >> shot: anObject [
	
	shot := anObject
]

{ #category : #polymorphism }
FiRGClass >> superclass [
	
	shot superclass ifNil: [ ^ nil ].
	
	^ environment classNamed: shot superclass
]

{ #category : #polymorphism }
FiRGClass >> theNonMetaClass [
	
	^ self
]
