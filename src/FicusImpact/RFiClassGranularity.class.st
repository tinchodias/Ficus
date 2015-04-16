Class {
	#name : #RFiClassGranularity,
	#superclass : #RFiGranularity,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
RFiClassGranularity >> allEntitiesFor: aFiRGEnvironment [ 
	
	^ aFiRGEnvironment allClassesAndTraits
]

{ #category : #accessing }
RFiClassGranularity >> entityFor: aFiRGObject [ 

	aFiRGObject isBehavior
		ifTrue: [ ^ aFiRGObject theNonMetaClass ].
	
	aFiRGObject isCompiledMethod
		ifTrue: [ ^ aFiRGObject methodClass theNonMetaClass ].
		
	self notYetImplemented
]
