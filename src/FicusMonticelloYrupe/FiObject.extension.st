Extension { #name : #FiObject }

{ #category : #'*FicusMonticelloYrupe' }
FiObject >> yrupeDefaultEncoder [ 

	^ YrTreeEncoding new
]

{ #category : #'*FicusMonticelloYrupe' }
FiObject >> yrupeEncoderFor: step [
	
	^ (self valueAt: step) yrupeDefaultEncoder
]

{ #category : #'*FicusMonticelloYrupe' }
FiObject >> yrupeKeysAndValuesDo: aBlockClosure [ 

	^ self stepsAndValuesDo: aBlockClosure 
]

{ #category : #'*FicusMonticelloYrupe' }
FiObject classSide >> yrupeNewFromKeysAndValues: aDictionary [

	^ self newFromStepsAndValues: aDictionary
]
