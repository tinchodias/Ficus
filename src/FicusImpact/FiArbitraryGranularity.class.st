Class {
	#name : #FiArbitraryGranularity,
	#superclass : #FiGranularity,
	#category : #'FicusImpact-Graph'
}

{ #category : #accessing }
FiArbitraryGranularity >> allEntitiesFor: aFiRGEnvironment [ 
	
	^ aFiRGEnvironment allClassesAndTraits flatCollect: [ :each |
		each methods, each classSide methods ]
]

{ #category : #accessing }
FiArbitraryGranularity >> entityFor: aFiRGObject [ 

	^ aFiRGObject
]
