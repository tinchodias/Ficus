Extension { #name : #FiBehavior }

{ #category : #'*FicusMonticelloYrupe' }
FiBehavior >> yrupeEncoderFor: step [
	
	^ #layout == step
		ifTrue: [ (self valueAt: step) yrupeLeafEncoder ]
		ifFalse: [ super yrupeEncoderFor: step ]
]
