Class {
	#name : #FiClassDependenciesCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Tests'
}

{ #category : #public }
FiClassDependenciesCollector >> dependenciesFor: aRingClass [ 

	aRingClass shot superclass ifNil: [ ^ #() ].
	
	^ { 
		FiClassReference builder
			theName: aRingClass shot superclass;
			new }
]
