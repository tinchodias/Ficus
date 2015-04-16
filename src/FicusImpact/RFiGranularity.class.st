Class {
	#name : #RFiGranularity,
	#superclass : #Object,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
RFiGranularity >> allEntitiesFor: aFiRGEnvironment [ 
	
	^ self subclassResponsibility 
]

{ #category : #accessing }
RFiGranularity >> entityFor: aFiRGObject [ 

	^ self subclassResponsibility 
]
