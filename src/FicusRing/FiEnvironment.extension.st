Extension { #name : #FiEnvironment }

{ #category : #'*FicusRing' }
FiEnvironment >> asRFiEnvironment [

	^ RFiEnvironment ficusEnvironment: self
]
