Extension { #name : #FiClass }

{ #category : #'*FicusMonticelloYrupe' }
FiClass >> yrupeEncoderFor: step [
	
	^ (#(classPool sharedPools) includes: step)
		ifTrue: [ (self valueAt: step) yrupeLeafEncoder ]
		ifFalse: [ super yrupeEncoderFor: step ]
]
