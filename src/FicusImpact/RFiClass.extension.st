Extension { #name : #RFiClass }

{ #category : #'*FicusImpact' }
RFiClass >> ficusAllDependencies [
	
	^ super ficusAllDependencies, (self methods flatCollect: #ficusAllDependencies)
]

{ #category : #'*FicusImpact' }
RFiClass >> ficusRequisites [
	
	^ FiClassRequisiteCollector new requisitesFor: self
]
