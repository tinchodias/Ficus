Extension { #name : #FiSet }

{ #category : #'*FicusRing' }
FiSet >> asFiRGEnvironment [

	^ RFiEnvironment new
		environmentShot: self;
		yourself.

]
