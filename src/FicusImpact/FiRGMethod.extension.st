Extension { #name : #FiRGMethod }

{ #category : #'*FicusImpact' }
FiRGMethod >> ficusRequisites [

	^ FiMethodRequisiteCollector new requisitesFor: self
]
