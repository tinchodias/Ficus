Class {
	#name : #FiClassRequisiteCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Requisites'
}

{ #category : #public }
FiClassRequisiteCollector >> requisitesFor: aFiRGClass [ 

	^ aFiRGClass classShot hasNullSuperclass 
		ifTrue: [ #() ]
		ifFalse: [ { 
			FiInheritanceDeclaration builder
				theClassName: aFiRGClass classShot superclassName;
				new } ]
]
