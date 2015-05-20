Extension { #name : #RFiLintRulesBrowser }

{ #category : #'*FicusMonticelloYrupe' }
RFiLintRulesBrowser classSide >> example2 [

	| rbEnvironment |
	self flag: #fix. "Shouldn't depend on Yrupe"
	
	rbEnvironment := 
		(FiRBBrowserEnvironment new 
			environment: (YrPharoMigrator example1readTag: '30014') asRFiEnvironment) 
			forCategories: #('Fuel-Core' 'Fuel-Clusters').
	
	^ self exampleOn: rbEnvironment
]
