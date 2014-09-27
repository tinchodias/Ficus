"
I represent an abstract FiBehavior's layout with slots.
"
Class {
	#name : #FiPointerLayout,
	#superclass : #FiLayout,
	#instVars : [
		'instanceVariables'
	],
	#category : #FicusMetamodel
}

{ #category : #initialization }
FiPointerLayout >> initialize [

	super initialize.

	instanceVariables := FiSet new
]

{ #category : #accessing }
FiPointerLayout >> instanceVariables [
	
	^ instanceVariables
]

{ #category : #printing }
FiPointerLayout >> printOn: aStream [

	super printOn: aStream.

	instanceVariables values printElementsOn: aStream.
	
]
