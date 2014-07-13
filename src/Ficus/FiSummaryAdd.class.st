Class {
	#name : #FiSummaryAdd,
	#superclass : #FiEditEffectSummary,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-UI-Summaries'
}

{ #category : #accessing }
FiSummaryAdd >> newValue [
	
	^ newValue
]

{ #category : #printing }
FiSummaryAdd >> newValueString [

	^ (newValue isShot 
		ifTrue: [ newValue values ]
		ifFalse: [ newValue ]) asString
]
