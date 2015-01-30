Extension { #name : #RBCompositeLintRule }

{ #category : #'*FicusRing' }
RBCompositeLintRule >> resetResultOnEnvironment: rbEnvironment [

	rules do: [ :each | each resetResultOnEnvironment: rbEnvironment ]
]
