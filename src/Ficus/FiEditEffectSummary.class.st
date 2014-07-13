Class {
	#name : #FiEditEffectSummary,
	#superclass : #FiFixedObject,
	#instVars : [
		'step',
		'subSummary'
	],
	#category : #'Ficus-UI-Summaries'
}

{ #category : #enumerating }
FiEditEffectSummary >> leavesDo: aBlockClosure basePath: aPath [ 
	
	^ subSummary 
		ifEmpty: [ aBlockClosure value: self value: aPath ]
		ifNotEmpty: [ subSummary do: [ :each |
			each leavesDo: aBlockClosure basePath: aPath / each step ] ].
]

{ #category : #printing }
FiEditEffectSummary >> newValueString [

	^ ''
]

{ #category : #printing }
FiEditEffectSummary >> oldValueString [

	^ ''
]

{ #category : #printing }
FiEditEffectSummary >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: step;
		nextPut: $).
]

{ #category : #accessing }
FiEditEffectSummary >> step [
	
	^ step
]

{ #category : #accessing }
FiEditEffectSummary >> subSummary [

	^ subSummary
]
