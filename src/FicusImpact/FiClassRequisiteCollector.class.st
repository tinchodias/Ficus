Class {
	#name : #FiClassRequisiteCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Requisites'
}

{ #category : #public }
FiClassRequisiteCollector >> requisitesFor: aRingClass [ 

	aRingClass classShot hasNullSuperclass ifTrue: [ ^ #() ].
	
	^ { 
		FiInheritanceDeclaration builder
			theClassName: aRingClass classShot superclassName;
			new }
]
