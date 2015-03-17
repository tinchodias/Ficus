Extension { #name : #FiShot }

{ #category : #'*FicusMonticelloYrupe' }
FiShot >> yrupeDefaultEncoder [ 

	^ YrTreeEncoding new
]

{ #category : #'*FicusMonticelloYrupe' }
FiShot >> yrupeEncoderFor: step [
	
	^ (self valueAt: step) yrupeDefaultEncoder
]

{ #category : #'*FicusMonticelloYrupe' }
FiShot >> yrupeKeysAndValuesDo: aBlockClosure [ 

	^ self stepsAndValuesDo: aBlockClosure 
]

{ #category : #'*FicusMonticelloYrupe' }
FiShot classSide >> yrupeNewFromKeysAndValues: aDictionary [

	^ self newFromStepsAndValues: aDictionary
]
