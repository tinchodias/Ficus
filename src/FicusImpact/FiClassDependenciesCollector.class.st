Class {
	#name : #FiClassDependenciesCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
FiClassDependenciesCollector >> dependenciesFor: aRingClass [ 

	aRingClass shot superclassName ifNil: [ ^ #() ].
	
	^ { 
		FiClassReference builder
			theName: aRingClass shot superclassName;
			new }
]
