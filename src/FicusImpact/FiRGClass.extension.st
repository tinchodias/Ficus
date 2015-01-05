Extension { #name : #FiRGClass }

{ #category : #'*FicusImpact' }
FiRGClass >> ficusRequisites [
	
	^ FiClassRequisiteCollector new requisitesFor: self
]
