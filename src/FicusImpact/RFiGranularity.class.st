Class {
	#name : #RFiGranularity,
	#superclass : #Object,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
RFiGranularity >> allEntitiesFor: aRFiEnvironment [ 
	
	^ self subclassResponsibility 
]

{ #category : #accessing }
RFiGranularity >> entityFor: aRFiObject [ 

	^ self subclassResponsibility 
]
