Class {
	#name : #FiGranularity,
	#superclass : #Object,
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
FiGranularity >> allEntitiesFor: aFiRGEnvironment [ 
	
	^ self subclassResponsibility 
]

{ #category : #accessing }
FiGranularity >> entityFor: aFiRGObject [ 

	^ self subclassResponsibility 
]
