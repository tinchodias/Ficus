"
I represent a trait.
"
Class {
	#name : #RFiTrait,
	#superclass : #RFiAbstractTrait,
	#instVars : [
		'environment',
		'ficusTrait',
		'cachedClassTrait'
	],
	#category : #'FicusRing-Core'
}

{ #category : #'instance-creation' }
RFiTrait class >> environment: aRFiEnvironment ficusTrait: aFiTrait [ 

	^ self basicNew
		initializeWithEnvironment: aRFiEnvironment 
		ficusTrait: aFiTrait;
		yourself
]

{ #category : #polymorphism }
RFiTrait >> classTrait [
	
	^ self classSide
]

{ #category : #private }
RFiTrait >> definition [
	"Answer a String that defines the receiver"

	^String streamContents: [:stream |
		stream nextPutAll: 'Trait'.
		stream nextPutAll: ' named: ';
				store: self name.
		stream cr; tab; nextPutAll: 'uses: ';
				nextPutAll: self traitCompositionString.
		stream cr; tab; nextPutAll: 'category: ';
				store: self category asString].
]

{ #category : #polymorphism }
RFiTrait >> environment [

	^ environment
]

{ #category : #accessing }
RFiTrait >> ficusTrait [

	^ ficusTrait
]

{ #category : #'initialize - release' }
RFiTrait >> initializeWithEnvironment: aRFiEnvironment ficusTrait: aFiTrait [ 
	
	self initialize.
	
	environment := aRFiEnvironment.
	ficusTrait := aFiTrait.
]

{ #category : #testing }
RFiTrait >> isMeta [
	
	^ false
]

{ #category : #accessing }
RFiTrait >> name [

	^ self ficusTrait name
]

{ #category : #printing }
RFiTrait >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #polymorphism }
RFiTrait >> theMetaClass [

	^ cachedClassTrait ifNil: [ 
		cachedClassTrait := RFiClassTrait new
			instanceSide: self;
			yourself ]
]

{ #category : #polymorphism }
RFiTrait >> theNonMetaClass [
	
	^ self
]
