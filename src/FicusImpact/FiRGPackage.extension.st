Extension { #name : #FiRGPackage }

{ #category : #'*FicusImpact' }
FiRGPackage >> ficusAllDependencies [
	
	^ super ficusAllDependencies, (self definedClasses flatCollect: #ficusAllDependencies as: OrderedCollection)
]

{ #category : #'*FicusImpact' }
FiRGPackage >> ficusRequisites [

	^ #()
]
