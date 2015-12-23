Extension { #name : #RFiMethod }

{ #category : #'*FicusImpact' }
RFiMethod >> ficusRequisites [

	^ RFiMethodRequisiteCollector new requisitesFor: self
]
