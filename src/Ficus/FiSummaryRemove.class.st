Class {
	#name : #FiSummaryRemove,
	#superclass : #FiEditEffectSummary,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-UI-Summaries'
}

{ #category : #accessing }
FiSummaryRemove >> oldValue [
	
	^ oldValue
]

{ #category : #printing }
FiSummaryRemove >> oldValueString [

	^ (oldValue isShot 
		ifTrue: [ oldValue values ]
		ifFalse: [ oldValue ]) asString
]
