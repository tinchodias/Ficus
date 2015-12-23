Class {
	#name : #RFiAtomicGranularity,
	#superclass : #RFiGranularity,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
RFiAtomicGranularity >> allEntitiesFor: aRFiEnvironment [ 
	
	^ aRFiEnvironment allClassesAndTraits flatCollect: [ :each |
		each methods, each classSide methods ]
]

{ #category : #accessing }
RFiAtomicGranularity >> entityFor: aRFiObject [ 

	^ aRFiObject
]
