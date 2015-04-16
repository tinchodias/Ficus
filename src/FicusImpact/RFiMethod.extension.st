Extension { #name : #RFiMethod }

{ #category : #'*FicusImpact' }
RFiMethod >> ficusRequisites [

	^ FiMethodRequisiteCollector new requisitesFor: self
]
