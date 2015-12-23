Extension { #name : #RFiPackage }

{ #category : #'*FicusImpact' }
RFiPackage >> ficusAllDependencies [
	
	^ super ficusAllDependencies, (self definedClasses flatCollect: #ficusAllDependencies as: OrderedCollection)
]

{ #category : #'*FicusImpact' }
RFiPackage >> ficusRequisites [

	^ #()
]
