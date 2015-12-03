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

{ #category : #'instance creation' }
FiPointerLayout class >> withInstanceVariableNames: names [

	| ficusInstanceVariables |
	ficusInstanceVariables := names collectWithIndex: [ :each :index |
		FiInstanceVariable builder
				index: index;
				name: each asSymbol;
				new ].

	^ FiFixedLayout builder
		instanceVariables: ficusInstanceVariables asFiSet;
		new
]

{ #category : #'instance creation' }
FiPointerLayout class >> withInstanceVariables: names [

	^ FiFixedLayout builder
		instanceVariables: names asFiSet;
		new
]

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
