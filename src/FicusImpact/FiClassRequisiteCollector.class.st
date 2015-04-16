Class {
	#name : #FiClassRequisiteCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Requisites'
}

{ #category : #public }
FiClassRequisiteCollector >> requisitesFor: aFiRGClass [ 

	^ aFiRGClass ficusClass hasNullSuperclass 
		ifTrue: [ #() ]
		ifFalse: [ { 
			FiInheritanceDeclaration builder
				theClassName: aFiRGClass ficusClass superclassName;
				new } ]
]
