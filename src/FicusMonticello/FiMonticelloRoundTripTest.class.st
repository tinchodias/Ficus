Class {
	#name : #FiMonticelloRoundTripTest,
	#superclass : #MCTestCase,
	#instVars : [
		'marshaler',
		'unmarshaler'
	],
	#category : #FicusMonticello
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

	^ #(test04Organization)
]

{ #category : #running }
FiMonticelloRoundTripTest >> marshaled: aMCSnapshot [
	
	^ marshaler marshaled: aMCSnapshot
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
		self mockClassB asClassDefinition. }
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

{ #category : #running }
FiMonticelloRoundTripTest >> unmarshaled: aFicusShot [
	
	^ unmarshaler unmarshaled: aFicusShot 
]
