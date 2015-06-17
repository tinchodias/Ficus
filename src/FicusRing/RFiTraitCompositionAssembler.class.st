"
I am a visitor of a Trait Composition AST. I'll visit the AST and build a Trait composition object from it.
"
Class {
	#name : #RFiTraitCompositionAssembler,
	#superclass : #Object,
	#instVars : [
		'transformations',
		'environment'
	],
	#category : #'FicusRing-Core'
}

{ #category : #'instance creation' }
RFiTraitCompositionAssembler class >> on: anEnvironment [
	^self new
		environment: anEnvironment;
		yourself
]

{ #category : #accessing }
RFiTraitCompositionAssembler >> environment: anObject [
	
	environment := anObject
]

{ #category : #visiting }
RFiTraitCompositionAssembler >> visitArrayNode: aRBArrayNode [ 
	
	^ aRBArrayNode value statements collect: [ :stmt | stmt acceptVisitor: self ]
]

{ #category : #visiting }
RFiTraitCompositionAssembler >> visitLiteralArrayNode: aRBArrayNode [ 
	"If it is an empty trait composition"
	^aRBArrayNode value collect: [ :stmt | stmt accept: self ]
]

{ #category : #visiting }
RFiTraitCompositionAssembler >> visitLiteralNode: aRBLiteralValueNode [ 
	
	^ environment 
		at: aRBLiteralValueNode value 
		ifAbsent: [ aRBLiteralValueNode value ]
]

{ #category : #visiting }
RFiTraitCompositionAssembler >> visitMessageNode: aRBMessageNode [

	| receiver selector arguments |
	receiver := aRBMessageNode receiver acceptVisitor: self.
	selector := aRBMessageNode selector.
	arguments := aRBMessageNode arguments collect: [ :arg |
		arg acceptVisitor: self.
	].
	^receiver
		perform: selector
		withArguments: arguments asArray.
]

{ #category : #visiting }
RFiTraitCompositionAssembler >> visitVariableNode: aVariableNode [
	"If it is an empty trait composition"
	
	(environment includesClassNamed: aVariableNode name) ifTrue: [
		^(environment classNamed: aVariableNode name).
	] ifFalse: [
		self error: 'Cannot handle this variable'
	].
]
