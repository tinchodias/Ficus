Class {
	#name : #FiClassDependenciesCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
FiClassDependenciesCollector >> dependenciesFor: aRingClass [ 

	aRingClass classShot hasNullSuperclass ifTrue: [ ^ #() ].
	
	^ { 
		FiInheritanceDeclaration builder
			theClassName: aRingClass classShot superclassName;
			new }
]
