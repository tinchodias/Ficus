Extension { #name : #RFiEnvironment }

{ #category : #'*FicusImpact' }
RFiEnvironment >> ficusAllDependencies [
	
	^ super ficusAllDependencies, (self packages flatCollect: #ficusAllDependencies as: OrderedCollection)
]

{ #category : #'*FicusImpact' }
RFiEnvironment >> ficusDependenciesForRedoing: aSimpleEffect [
	
	| entities |
	entities := Array streamContents: [ :stream |
		aSimpleEffect relevantSimpleEffectsDo: [ :child |
			| block |
			block := [ 
				stream nextPut: (self ficusRGObjectFromPath: child path) ].
			child 
				ifAdd: block
				ifRemove: []
				ifUpdate: block ] ].
	
	^ entities flatCollect: #ficusDependencies

]
