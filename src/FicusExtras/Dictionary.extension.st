Extension { #name : #Dictionary }

{ #category : #'*FicusExtras' }
Dictionary >> asFiDictionary [
	
	^ FiDictionary newFromStepsAndValues: self
	
]
