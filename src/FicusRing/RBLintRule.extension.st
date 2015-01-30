Extension { #name : #RBLintRule }

{ #category : #'*FicusRing' }
RBLintRule >> criticsOnEnvironment: rbEnvironment [ 

	^ (self resultOnEnvironment: rbEnvironment) smallLintCritics
]

{ #category : #'*FicusRing' }
RBLintRule >> resetResultOnEnvironment: rbEnvironment [

]

{ #category : #'*FicusRing' }
RBLintRule >> resultOnEnvironment: rbEnvironment [

	^ self result 
		onEnvironment: rbEnvironment; 
		yourself
]
