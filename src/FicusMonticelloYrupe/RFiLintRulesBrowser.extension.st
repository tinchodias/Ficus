Extension { #name : #RFiLintRulesBrowser }

{ #category : #'*FicusMonticelloYrupe' }
RFiLintRulesBrowser classSide >> example2 [

	| rbEnvironment |
	rbEnvironment := 
		(FiRBBrowserEnvironment new 
			environment: (YrGitPharoExporter example1readTag: '30014') asRFiEnvironment) 
			forCategories: #('Fuel-Core' 'Fuel-Clusters').
	
	^ self exampleOn: rbEnvironment
]
