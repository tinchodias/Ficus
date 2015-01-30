Extension { #name : #RBLintRule }

{ #category : #'*FicusRing' }
RBLintRule >> resetResultOnEnvironment: rbEnvironment [

]

{ #category : #'*FicusRing' }
RBLintRule >> resultOnEnvironment: rbEnvironment [

	^ self result 
		onEnvironment: rbEnvironment; 
		yourself
]
