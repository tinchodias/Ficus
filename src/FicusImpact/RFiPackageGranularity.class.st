Class {
	#name : #RFiPackageGranularity,
	#superclass : #RFiGranularity,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
RFiPackageGranularity >> allEntitiesFor: aFiRGEnvironment [ 
	
	^ aFiRGEnvironment packages
]

{ #category : #accessing }
RFiPackageGranularity >> entityFor: aFiRGObject [ 

	^ aFiRGObject package
]
