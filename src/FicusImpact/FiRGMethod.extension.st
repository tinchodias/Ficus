Extension { #name : #FiRGMethod }

{ #category : #'*FicusImpact' }
FiRGMethod >> ficusDependencies [

	^ FiMethodDependenciesCollector new dependenciesFor: self
]
