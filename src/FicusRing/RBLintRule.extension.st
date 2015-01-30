Extension { #name : #RBLintRule }

{ #category : #'*FicusRing' }
RBLintRule >> resultOnEnvironment: rbEnvironment [

	^ self result 
		onEnvironment: rbEnvironment; 
		yourself
]
