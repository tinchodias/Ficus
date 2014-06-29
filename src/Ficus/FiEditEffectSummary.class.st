Class {
	#name : #FiEditEffectSummary,
	#superclass : #FiFixedObject,
	#instVars : [
		'step',
		'subSummary'
	],
	#category : #'Ficus-UI-Summaries'
}

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
