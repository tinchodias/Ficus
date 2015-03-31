Class {
	#name : #FiAtomicGranularity,
	#superclass : #FiGranularity,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
FiAtomicGranularity >> allEntitiesFor: aFiRGEnvironment [ 
	
	^ aFiRGEnvironment allClassesAndTraits flatCollect: [ :each |
		each methods, each classSide methods ]
]

{ #category : #accessing }
FiAtomicGranularity >> entityFor: aFiRGObject [ 

	^ aFiRGObject
]
