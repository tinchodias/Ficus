Class {
	#name : #FiLintRulesBrowser,
	#superclass : #Object,
	#category : #'FicusRing-UI'
}

{ #category : #examples }
FiLintRulesBrowser class >> example1 [

	| rbEnvironment compositeRule |
	rbEnvironment := FiRBBrowserEnvironment new environment: FiFragileBaseProblemResources new environmentWithAll asFiRGEnvironment.
	compositeRule := FiLintRulesTest new newRule.

	RBSmalllintChecker 
		runRule: compositeRule
		onEnvironment: rbEnvironment.
		
	^ self 
		openOn: rbEnvironment
		rules: compositeRule rules
]

{ #category : #examples }
FiLintRulesBrowser class >> example1b [

	| rbEnvironment compositeRule |
	rbEnvironment := FiRBBrowserEnvironment new environment: FiFragileBaseProblemResources new environmentWithAll asFiRGEnvironment.
	compositeRule := self goodRules.

	RBSmalllintChecker 
		runRule: compositeRule
		onEnvironment: rbEnvironment.
		
	^ self 
		openOn: rbEnvironment
		rules: compositeRule rules
]

{ #category : #examples }
FiLintRulesBrowser class >> example2 [

	| rbEnvironment compositeRule |
	self flag: #fix. "Shouldn't depend on Yrupe"
	
	rbEnvironment := FiRBBrowserEnvironment new environment: YrPharoMigrator example1readTag asFiRGEnvironment.
	compositeRule := FiLintRulesTest new newRule.

	RBSmalllintChecker 
		runRule: compositeRule
		onEnvironment: (rbEnvironment forCategories: #('Fuel-Core' 'Fuel-Clusters')).
		
	^ self 
		openOn: rbEnvironment
		rules: compositeRule rules
]

{ #category : #examples }
FiLintRulesBrowser class >> goodRules [ 

	self flag: #todo.

	^ RBCompositeLintRule allGoodRules
		removeRule: RBVariableNotDefinedRule new; 
		removeRule: RBLiteralArrayContainsSuspiciousTrueFalseOrNilRule new; "it checks compilation"
		removeRule: RBUnpackagedCodeRule new; "it access managers directly; anyway, we don't have unpackaged for the moment."
		removeRule: RBLiteralArrayContainsCommaRule new; "TODO: needs #allLiterals"
		yourself
]

{ #category : #'instance creation' }
FiLintRulesBrowser class >> newBrowserOn: rbEnvironment [

	| browser |
	browser := GLMTabulator new
		row: [ :row |
			row 
			 	column: #rules;
				column: #critics ];
		yourself.
		
	browser transmit 
		to: #rules;
		andShow: [ :a | 
			a list 
				display: [ :rulez | rulez sorted: [ :x :y | x name < y name ]];
				format: [ :rule | rule name, ' (', rule problemCount asString, ')' ] ].

	browser transmit 
		from: #rules;
		to: #critics;
		andShow: [ :a | 
			a list
				display: [ :rule  | (rule result onEnvironment: rbEnvironment; yourself) smallLintCritics ];
				format: [ :critic | critic asString ].
		 ].
			
	^ browser
]

{ #category : #convenience }
FiLintRulesBrowser class >> openOn: rbEnvironment rules: rules [

	^ (self newBrowserOn: rbEnvironment) openOn: rules
]
