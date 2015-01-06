Extension { #name : #FiRGEnvironment }

{ #category : #'*FicusImpact' }
FiRGEnvironment >> ficusAllDependencies [
	
	^ super ficusAllDependencies, (self packages flatCollect: #ficusAllDependencies as: OrderedCollection)
]
