Class {
	#name : #FiClassDependenciesCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
FiClassDependenciesCollector >> dependenciesFor: aRingClass [ 

	aRingClass classShot hasNullSuperclass ifTrue: [ ^ #() ].
	
	^ { 
		FiClassReference builder
			theName: aRingClass classShot superclassName;
			new }
]
