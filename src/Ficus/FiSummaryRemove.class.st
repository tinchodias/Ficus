Class {
	#name : #FiSummaryRemove,
	#superclass : #FiEditEffectSummary,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-UI-Model'
}

{ #category : #testing }
FiSummaryRemove >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ removeBlock cull: self
]

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
