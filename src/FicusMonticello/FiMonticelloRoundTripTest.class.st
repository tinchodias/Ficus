Class {
	#name : #FiMonticelloRoundTripTest,
	#superclass : #MCTestCase,
	#instVars : [
		'writer',
		'reader'
	],
	#category : #'FicusMonticello-Tests'
}

{ #category : #running }
FiMonticelloRoundTripTest >> assertRoundTripEquals: someMCDefinitions [

	| written read snapshot |
	snapshot := MCSnapshot fromDefinitions: someMCDefinitions.	

	written := self written: snapshot.
	read := self read: written.
		
	self assert: read equals: snapshot.

	"
	MCPatch fromBase: snapshot target: read.
	"

]

{ #category : #running }
FiMonticelloRoundTripTest >> expectedFailures [

	^ #(test04Organization test08ClassTrait)
]

{ #category : #running }
FiMonticelloRoundTripTest >> mockClassExtensionMethod [

	^ MCMethodDefinition 
		className: 'Integer'
		classIsMeta: true
		selector: 'fortyTwo'
		category: self mockExtensionMethodCategory 
		timeStamp: ''
		source: 'fortyTwo ^42'
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
		source: 'fortyTwo ^42'
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
FiMonticelloRoundTripTest >> read: aFicusShot [
	
	^ reader read: aFicusShot 
]

{ #category : #running }
FiMonticelloRoundTripTest >> setUp [

	self setUpWriter.
	self setUpReader.
]

{ #category : #running }
FiMonticelloRoundTripTest >> setUpReader [

	reader := FiMonticelloReader new
]

{ #category : #running }
FiMonticelloRoundTripTest >> setUpWriter [

	writer := FiMonticelloWriter new
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
FiMonticelloRoundTripTest >> written: aMCSnapshot [
	
	^ writer written: aMCSnapshot name: 'TestingName'
]
