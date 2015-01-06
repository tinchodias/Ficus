Class {
	#name : #FiPackageGranularity,
	#superclass : #Object,
	#category : #'FicusImpact-Graph'
}

{ #category : #'as yet unclassified' }
FiPackageGranularity >> allEntitiesFor: aFiRGEnvironment [ 
	
	^ aFiRGEnvironment packages
]

{ #category : #'as yet unclassified' }
FiPackageGranularity >> entityFor: aFiRGObject [ 

	^ aFiRGObject package
]
