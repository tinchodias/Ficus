Class {
	#name : #RFiClassRequisiteCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Requisites'
}

{ #category : #public }
RFiClassRequisiteCollector >> requisitesFor: aFiRGClass [ 

	^ aFiRGClass ficusClass hasNullSuperclass 
		ifTrue: [ #() ]
		ifFalse: [ { 
			RFiInheritanceDeclaration builder
				theClassName: aFiRGClass ficusClass superclassName;
				new } ]
]
