Extension { #name : #FiRGEnvironment }

{ #category : #'*FicusImpact' }
FiRGEnvironment >> ficusAllDependencies [
	
	^ super ficusAllDependencies, (self allClassesAndTraits flatCollect: #ficusAllDependencies as: OrderedCollection)
]

{ #category : #'*FicusImpact' }
FiRGEnvironment >> ficusDependencies [
	
	^ #()
]
