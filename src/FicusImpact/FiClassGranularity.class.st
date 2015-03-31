Class {
	#name : #FiClassGranularity,
	#superclass : #FiGranularity,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
FiClassGranularity >> allEntitiesFor: aFiRGEnvironment [ 
	
	^ aFiRGEnvironment allClassesAndTraits
]

{ #category : #accessing }
FiClassGranularity >> entityFor: aFiRGObject [ 

	aFiRGObject isBehavior
		ifTrue: [ ^ aFiRGObject theNonMetaClass ].
	
	aFiRGObject isCompiledMethod
		ifTrue: [ ^ aFiRGObject methodClass theNonMetaClass ].
		
	self notYetImplemented
]
