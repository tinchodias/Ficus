Class {
	#name : #FiSummaryAdd,
	#superclass : #FiEditEffectSummary,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-UI-Model'
}

{ #category : #testing }
FiSummaryAdd >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ addBlock cull: self
]

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
