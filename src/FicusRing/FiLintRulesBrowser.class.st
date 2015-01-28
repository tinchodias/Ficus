Class {
	#name : #FiLintRulesBrowser,
	#superclass : #Object,
	#category : #'FicusRing-UI'
}

{ #category : #examples }
FiLintRulesBrowser class >> example1 [

	| rbEnvironment compositeRule |
	rbEnvironment := FiRBBrowserEnvironment new environment: FiFragileBaseProblemResources new ficusRGEnvironment.
	compositeRule := FiLintRulesTest new newRule.

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
	
	rbEnvironment := FiRBBrowserEnvironment new environment: YrPharoMigrator example1readHead asFiRGEnvironment.
	compositeRule := FiLintRulesTest new newRule.

	RBSmalllintChecker 
		runRule: compositeRule
		onEnvironment: (rbEnvironment forCategories: #('Fuel-Core' 'Fuel-Clusters')).
		
	^ self 
		openOn: rbEnvironment
		rules: compositeRule rules
]

{ #category : #'instance creation' }
FiLintRulesBrowser class >> newBrowserOn: rbEnvironment [

	| browser |
	browser := GLMTabulator new
		row: [ :row |
			row 
			 	column: #rules;
				column: #critics ];
		title: 'Ficus Lint Rules Runner';
		yourself.
		
	browser transmit 
		to: #rules;
		andShow: [ :a | 
			a list 
				display: [ :rulez | rulez flatCollect: [:each | each leaves ] ];
				sorted: [ :x :y | 
					x problemCount compareWith: y problemCount
						ifLesser: [ false ] 
						ifEqual: [ x name < y name ] 
						ifGreater: [ true ] ];
				format: [ :rule | rule name, ' (', rule problemCount asString, ')' ];
				tags: [ :rule | {rule group. rule category. rule severity} ] ].

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
