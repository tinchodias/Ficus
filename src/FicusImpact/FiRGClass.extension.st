Extension { #name : #FiRGClass }

{ #category : #'*FicusImpact' }
FiRGClass >> ficusAllDependencies [
	
	^ super ficusAllDependencies, (self methods flatCollect: #ficusAllDependencies)
]

{ #category : #'*FicusImpact' }
FiRGClass >> ficusRequisites [
	
	^ FiClassRequisiteCollector new requisitesFor: self
]
