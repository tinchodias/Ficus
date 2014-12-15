Extension { #name : #FiRGClass }

{ #category : #'*FicusImpact' }
FiRGClass >> ficusDependencies [
	
	^ FiClassDependenciesCollector new dependenciesFor: self
]
