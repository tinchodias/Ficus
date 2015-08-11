"
I represent an FiBehavior's layout with named slots.
"
Class {
	#name : #FiFixedLayout,
	#superclass : #FiPointerLayout,
	#category : #'FicusMetamodel-Core'
}

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
