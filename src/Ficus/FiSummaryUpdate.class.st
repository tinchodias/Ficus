Class {
	#name : #FiSummaryUpdate,
	#superclass : #FiEditEffectSummary,
	#instVars : [
		'newValue',
		'oldValue'
	],
	#category : #'Ficus-UI-Model'
}

{ #category : #testing }
FiSummaryUpdate >> ifAdd: addBlock ifRemove: removeBlock ifUpdate: updateBlock [
	
	^ updateBlock cull: self
]

{ #category : #accessing }
FiSummaryUpdate >> newValue [
	
	^ newValue
]

{ #category : #printing }
FiSummaryUpdate >> newValueString [

	^ (newValue isShot 
		ifTrue: [ newValue values ]
		ifFalse: [ newValue ]) asString
]

{ #category : #accessing }
FiSummaryUpdate >> oldValue [
	
	^ oldValue
]

{ #category : #printing }
FiSummaryUpdate >> oldValueString [

	^ (oldValue isShot 
		ifTrue: [ oldValue values ]
		ifFalse: [ oldValue ]) asString
]
