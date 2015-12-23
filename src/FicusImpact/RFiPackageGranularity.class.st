Class {
	#name : #RFiPackageGranularity,
	#superclass : #RFiGranularity,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
RFiPackageGranularity >> allEntitiesFor: aRFiEnvironment [ 
	
	^ aRFiEnvironment packages
]

{ #category : #accessing }
RFiPackageGranularity >> entityFor: aRFiObject [ 

	^ aRFiObject package
]
