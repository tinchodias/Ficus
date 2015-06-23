Extension { #name : #RFiEnvironment }

{ #category : #'*FicusImpact' }
RFiEnvironment >> ficusAllDependencies [
	
	^ super ficusAllDependencies, (self packages flatCollect: #ficusAllDependencies as: OrderedCollection)
]

{ #category : #'*FicusImpact' }
RFiEnvironment >> ficusDependenciesForRedoing: aSimpleChange [
	
	| entities |
	entities := Array streamContents: [ :stream |
		aSimpleChange relevantSimpleChangesDo: [ :child |
			| block |
			block := [ 
				stream nextPut: (self ficusRGObjectFromPath: child path) ].
			child 
				ifAdd: block
				ifRemove: []
				ifUpdate: block ] ].
	
	^ entities flatCollect: #ficusDependencies

]

{ #category : #'*FicusImpact' }
RFiEnvironment >> ficusRGObjectFromPath: aFiPath [
	
	| steps |
	self flag: #todo. "FIX..."
	
	steps := aFiPath steps.
	
	steps size < 5 ifTrue: [ self notYetImplemented  ].
	
	steps fifth = #methods ifTrue: [ 
		^ (self classNamed: steps fourth) >> steps sixth ].

	steps fifth = #layout ifTrue: [ 
		^ self classNamed: steps fourth ].

	steps fifth = #metaclass ifTrue: [ 
		^ (self classNamed: steps fourth) theMetaClass ].
	
	self notYetImplemented 
]
