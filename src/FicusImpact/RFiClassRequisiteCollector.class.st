Class {
	#name : #RFiClassRequisiteCollector,
	#superclass : #Object,
	#category : #'FicusImpact-Interpreting'
}

{ #category : #public }
RFiClassRequisiteCollector >> requisitesFor: aRFiClass [ 

	^ aRFiClass ficusClass hasNullSuperclass 
		ifTrue: [ #() ]
		ifFalse: [ { 
			RFiInheritanceDeclaration builder
				theClassName: aRFiClass ficusClass superclassName;
				new } ]
]
