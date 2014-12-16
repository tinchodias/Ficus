Extension { #name : #FiSet }

{ #category : #'*FicusRing' }
FiSet >> asFiRGEnvironment [

	^ FiRGEnvironment new
		environmentShot: self;
		yourself.

]
