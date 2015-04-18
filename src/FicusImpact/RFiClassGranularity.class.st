Class {
	#name : #RFiClassGranularity,
	#superclass : #RFiGranularity,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
RFiClassGranularity >> allEntitiesFor: aRFiEnvironment [ 
	
	^ aRFiEnvironment allClassesAndTraits
]

{ #category : #accessing }
RFiClassGranularity >> entityFor: aRFiObject [ 

	aRFiObject isBehavior
		ifTrue: [ ^ aRFiObject theNonMetaClass ].
	
	aRFiObject isCompiledMethod
		ifTrue: [ ^ aRFiObject methodClass theNonMetaClass ].
		
	self notYetImplemented
]
