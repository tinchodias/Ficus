"
I represent a class.
"
Class {
	#name : #FiClass,
	#superclass : #FiBehavior,
	#instVars : [
		'metaclass',
		'classPool',
		'sharedPools',
		'category',
		'comment',
		'traitComposition',
		'superclassName',
		'name'
	],
	#category : #FicusMetamodel
}

{ #category : #'instance creation' }
FiClass class >> named: aString [ 

	^ self builder
		name: aString;
		new
]

{ #category : #'default values' }
FiClass class >> nullSuperclassName [
	
	^ #nil
]

{ #category : #accessing }
FiClass >> category [

	^ category
]

{ #category : #accessing }
FiClass >> classPool [
	
	^ classPool
]

{ #category : #printing }
FiClass >> classVariablesString [
	
	^ Character space join: classPool asArray
]

{ #category : #accessing }
FiClass >> comment [

	^ comment asString
]

{ #category : #accessing }
FiClass >> defaultStep [

	^ name asSymbol
]

{ #category : #printing }
FiClass >> definition [
	"Answer a String that defines the receiver."

	| aStream |
	aStream := (String new: 800) writeStream.
	self hasNullSuperclass
		ifTrue: [aStream nextPutAll: 'ProtoObject' ]
		ifFalse: [aStream nextPutAll: self superclassName ].
	aStream nextPutAll: self kindOfSubclass;
			store: self name.
	aStream cr; tab; nextPutAll: 'uses: ';
			nextPutAll: self traitComposition.
	aStream cr; tab; nextPutAll: 'instanceVariableNames: ';
			store: self instanceVariablesString.
	aStream cr; tab; nextPutAll: 'classVariableNames: ';
			store: self classVariablesString.
	aStream cr; tab; nextPutAll: 'poolDictionaries: ';
			store: self sharedPoolsString.
	aStream cr; tab; nextPutAll: 'category: ';
			store: self category asString.

	self hasNullSuperclass ifTrue: [ 
		aStream nextPutAll: '.'; cr.
		aStream nextPutAll: self name.
		aStream space; nextPutAll: 'superclass: nil'. ].

	^ aStream contents
]

{ #category : #testing }
FiClass >> hasNullSuperclass [

	^ superclassName asSymbol == self class nullSuperclassName
]

{ #category : #initialize }
FiClass >> initialize [

	super initialize.

	name := #NoName.
	superclassName := self class nullSuperclassName.
	category := #NoCategory.
	classPool := FiSet new.
	comment := ''.
	sharedPools := FiSet new.
	metaclass := FiMetaclass new.
	traitComposition := '{}'.
]

{ #category : #testing }
FiClass >> isFicusClass [

	^ true
]

{ #category : #testing }
FiClass >> isFicusExtensionMethods [

	^ false
]

{ #category : #testing }
FiClass >> isFicusTrait [

	^ false
]

{ #category : #testing }
FiClass >> isMeta [

	^ false
]

{ #category : #printing }
FiClass >> kindOfSubclass [
	"Answer a String that is the keyword that describes the receiver's kind 
	of subclass, either a regular subclass, a variableSubclass, a  
	variableByteSubclass, a variableWordSubclass, or a weakSubclass."

	self flag: #todo. "FIX"
	^ ' subclass: '
]

{ #category : #accessing }
FiClass >> metaclass [
	^ metaclass
]

{ #category : #accessing }
FiClass >> name [
	
	^ name
]

{ #category : #accessing }
FiClass >> name: a [
	
	self
]

{ #category : #printing }
FiClass >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	name printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiClass >> privateComment [

	^ comment
]

{ #category : #accessing }
FiClass >> sharedPools [
	
	^ sharedPools
]

{ #category : #printing }
FiClass >> sharedPoolsString [

	^ Character space join: sharedPools asArray
]

{ #category : #accessing }
FiClass >> superclassName [
	
	^ superclassName
	
]

{ #category : #accessing }
FiClass >> traitComposition [
	
	^ traitComposition
]

{ #category : #accessing }
FiClass >> valueAt: step ifPresent: presentBlock ifAbsent: absentBlock [
	"I'm needed because the slot 'comment' can hold a FiRemoteString, thus the accessor has to be used."

	step == #comment ifTrue: [ ^ self comment ].
	
	^ super valueAt: step ifPresent: presentBlock ifAbsent: absentBlock
]
