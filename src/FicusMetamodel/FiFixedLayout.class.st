"
I represent an FiBehavior's layout with named slots.
"
Class {
	#name : #FiFixedLayout,
	#superclass : #FiPointerLayout,
	#category : #FicusMetamodel
}

{ #category : #'instance creation' }
FiFixedLayout class >> withInstanceVariables: names [

	^ FiFixedLayout builder
		instanceVariables: names asFiSet;
		new
]
