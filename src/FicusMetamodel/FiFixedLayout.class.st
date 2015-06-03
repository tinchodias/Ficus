"
I represent an FiBehavior's layout with named slots.
"
Class {
	#name : #FiFixedLayout,
	#superclass : #FiPointerLayout,
	#category : #'FicusMetamodel-Core'
}

{ #category : #'instance creation' }
FiFixedLayout class >> withInstanceVariableNames: names [

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
FiFixedLayout class >> withInstanceVariables: names [

	^ FiFixedLayout builder
		instanceVariables: names asFiSet;
		new
]

{ #category : #testing }
FiFixedLayout >> isFixedLayout [

	^ true
]
