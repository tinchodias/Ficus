Class {
	#name : #FiPackageGranularity,
	#superclass : #FiGranularity,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
FiPackageGranularity >> allEntitiesFor: aFiRGEnvironment [ 
	
	^ aFiRGEnvironment packages
]

{ #category : #accessing }
FiPackageGranularity >> entityFor: aFiRGObject [ 

	^ aFiRGObject package
]
