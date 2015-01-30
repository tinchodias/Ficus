Extension { #name : #RBLintRule }

{ #category : #'*FicusRing' }
RBLintRule >> criticsOnEnvironment: rbEnvironment [ 

	^ (self resultOnEnvironment: rbEnvironment) smallLintCritics
]

{ #category : #'*FicusRing' }
RBLintRule >> resetResultOnEnvironment: rbEnvironment [
	"Reset the results using the specified environment. 
	Ignore it by default."

	^ self resetResult
]

{ #category : #'*FicusRing' }
RBLintRule >> resultOnEnvironment: rbEnvironment [

	^ self result 
		onEnvironment: rbEnvironment; 
		yourself
]
