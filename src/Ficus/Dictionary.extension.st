Extension { #name : #Dictionary }

{ #category : #'*Ficus' }
Dictionary >> asFiDictionary [
	
	^ FiDictionary newFromStepsAndValues: self
	
]
