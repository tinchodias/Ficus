Extension { #name : #FiSet }

{ #category : #'*FicusRing' }
FiSet >> asRFiEnvironment [

	^ RFiEnvironment new
		environmentShot: self;
		yourself.

]
