"
I represent an abstract FiBehavior's layout with slots.
"
Class {
	#name : #FiPointerLayout,
	#superclass : #FiLayout,
	#instVars : [
		'instanceVariables'
	],
	#category : #'FicusMetamodel-Core'
}

{ #category : #initialization }
FiPointerLayout >> initialize [

	super initialize.

	instanceVariables := FiSet new
]

{ #category : #printing }
FiPointerLayout >> instanceVariableNames [
	
	^ self instanceVariables collect: #name
]

{ #category : #accessing }
FiPointerLayout >> instanceVariables [
	
	^ instanceVariables asArray sorted: [ :a :b | a index < b index ]
]

{ #category : #printing }
FiPointerLayout >> printOn: aStream [

	super printOn: aStream.

	instanceVariables values printElementsOn: aStream.
	
]
