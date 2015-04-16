Extension { #name : #FiSet }

{ #category : #'*FicusRing' }
FiSet >> asRFiEnvironment [

	^ RFiEnvironment ficusPackages: self
]
