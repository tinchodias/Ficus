Extension { #name : #RFiBaseResources }

{ #category : #'*FicusRing' }
RFiBaseResources >> browse [

	^ RFiEnvironmentBrowser openOn: self ringEnvironment
]

{ #category : #'*FicusRing' }
RFiBaseResources >> ringClassObject [

	^ self ringEnvironment classNamed: #Object
]

{ #category : #'*FicusRing' }
RFiBaseResources >> ringEnvironment [

	^ cachedRFiEnvironment ifNil: [
		cachedRFiEnvironment := self ficusEnvironment asRFiEnvironment ]
]
