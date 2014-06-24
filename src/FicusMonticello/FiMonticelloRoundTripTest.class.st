Class {
	#name : #FiMonticelloRoundTripTest,
	#superclass : #MCTestCase,
	#instVars : [
		'marshaler',
		'unmarshaler'
	],
	#category : #'FicusMonticello-Marshaling'
}

{ #category : #running }
FiMonticelloRoundTripTest >> assertRoundTripEquals: someMCDefinitions [

	| marshaled unmarshaled snapshot |
	snapshot := MCSnapshot fromDefinitions: someMCDefinitions.	

	marshaled := self marshaled: snapshot.
	unmarshaled := self unmarshaled: marshaled.
	
	self assert: unmarshaled equals: snapshot.
]

{ #category : #running }
FiMonticelloRoundTripTest >> expectedFailures [

	^ #(test04Organization test08ClassTrait)
]

{ #category : #running }
FiMonticelloRoundTripTest >> marshaled: aMCSnapshot [
	
	^ marshaler marshaled: aMCSnapshot name: 'TestingName'
]

{ #category : #running }
FiMonticelloRoundTripTest >> mockClassExtensionMethod [

	^ MCMethodDefinition 
		className: 'Integer'
		classIsMeta: true
		selector: 'fortyTwo'
		category: self mockExtensionMethodCategory 
		timeStamp: ''
		source: 'fotryTwo ^42'
]

{ #category : #running }
FiMonticelloRoundTripTest >> mockClassTrait [

	^ MCClassTraitDefinition
		baseTraitName: 'MCMockTrait'
		classTraitComposition: 'Trait1+ Trait2'
		category: self mockCategoryName
]

{ #category : #running }
FiMonticelloRoundTripTest >> mockClassWithTraitComposition [

	| className |
	className := 'MCMockClassC'.
	^ MCClassDefinition
		name: className
		superclassName: 'Object'
		traitComposition: 'Trait1 + Trait2'
		classTraitComposition: 'Trait3'
		category: self mockCategoryName
		instVarNames: #()
		classVarNames: #()
		poolDictionaryNames: #()
		classInstVarNames: #()
		type: #normal
		comment: (self commentForClass: className)
		commentStamp: (self commentStampForClass: className).

]

{ #category : #running }
FiMonticelloRoundTripTest >> mockExtensionMethod [

	^ MCMethodDefinition 
		className: 'Integer'
		classIsMeta: false
		selector: 'fortyTwo'
		category: self mockExtensionMethodCategory 
		timeStamp: ''
		source: 'fotryTwo ^42'
]

{ #category : #running }
FiMonticelloRoundTripTest >> mockTrait [

	| traitName |
	traitName := 'MCMockTrait'.
	^ MCTraitDefinition
		name: traitName
		traitComposition: 'Trait1+ Trait2'
		category: self mockCategoryName
		comment: (self commentForClass: traitName)
		commentStamp: (self commentStampForClass: traitName).

]

{ #category : #running }
FiMonticelloRoundTripTest >> setUp [

	self setUpMarshaler.
	self setUpUnmarshaler.
]

{ #category : #running }
FiMonticelloRoundTripTest >> setUpMarshaler [

	marshaler := FiMonticelloMarshaler new
]

{ #category : #running }
FiMonticelloRoundTripTest >> setUpUnmarshaler [

	unmarshaler := FiMonticelloUnmarshaler new
]

{ #category : #tests }
FiMonticelloRoundTripTest >> test01Class [

	self assertRoundTripEquals: { 
		self mockClassA asClassDefinition.
		self mockClassB asClassDefinition.
		self mockClassWithTraitComposition. }
]

{ #category : #tests }
FiMonticelloRoundTripTest >> test02Method [

	self assertRoundTripEquals: { 
		self mockClassB asClassDefinition.
		self 
			mockMethod: #one 
			class: self mockClassB name 
			source: 'one ^2' 
			meta: false.
		 }
]

{ #category : #tests }
FiMonticelloRoundTripTest >> test03ClassMethod [

	self assertRoundTripEquals: { 
		self mockClassB asClassDefinition.
		self 
			mockMethod: #one 
			class: self mockClassB name 
			source: 'one ^2' 
			meta: true.
		 }
]

{ #category : #tests }
FiMonticelloRoundTripTest >> test04Organization [

	self assertRoundTripEquals: { 
		self mockClassB asClassDefinition.
		MCOrganizationDefinition categories: { self mockClassB category } }
]

{ #category : #tests }
FiMonticelloRoundTripTest >> test05Trait [

	self assertRoundTripEquals: { 
		self mockTrait }
]

{ #category : #tests }
FiMonticelloRoundTripTest >> test06ExtensionMethod [

	self assertRoundTripEquals: { 
		self mockExtensionMethod }
]

{ #category : #tests }
FiMonticelloRoundTripTest >> test07ClassExtensionMethod [

	self assertRoundTripEquals: { 
		self mockClassExtensionMethod }
]

{ #category : #tests }
FiMonticelloRoundTripTest >> test08ClassTrait [

	self assertRoundTripEquals: { 
		self mockClassTrait.
		"todo: also put a method" }
]

{ #category : #running }
FiMonticelloRoundTripTest >> unmarshaled: aFicusShot [
	
	^ unmarshaler unmarshaled: aFicusShot 
]
