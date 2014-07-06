Class {
	#name : #FiClassDependenciesCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
FiClassDependenciesCollector >> dependenciesFor: aRingClass [ 

	aRingClass shot superclass ifNil: [ ^ #() ].
	
	^ { 
		FiClassReference builder
			theName: aRingClass shot superclass;
			new }
]
