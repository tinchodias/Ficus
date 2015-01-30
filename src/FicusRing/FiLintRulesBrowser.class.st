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
		column: [ :column |
			column row: [ :row |
				row 
				 	column: #rules;
					column: #critics ].
			column row: #criticDetail
				];
		title: 'Ficus Lint Rules Runner';
		yourself.
		
	browser transmit 
		to: #rules;
		andShow: [ :a | 
			a list 
				display: [ :rulez | 
					"generate pairs (rule, critics)"
					(rulez flatCollect: [ :rule | rule leaves ])
						collect: [ :rule | { 
							rule.
							rule criticsOnEnvironment: rbEnvironment.
							} ] ];					
				sorted: [ :x :y | 
					x second size compareWith: y second size
						ifLesser: [ false ] 
						ifEqual: [ x name < y name ] 
						ifGreater: [ true ] ];
				format: [ :ruleCritics | 
					ruleCritics first name, ' (', ruleCritics second size asString, ')' ];
				tags: [ :ruleCritics | {
					ruleCritics first group. 
					ruleCritics first category. 
					ruleCritics first severity } ];
				selectionAct: [ :list | list selection inspect ] on: $i entitled: 'Inspect' ].

	browser transmit 
		from: #rules;
		to: #critics;
		andShow: [ :a | 
			a list
				display: [ :ruleCritics | ruleCritics second ];
				sorted: [ :x :y | x shortPrintString < y shortPrintString ];
				format: [ :critic | critic shortPrintString ];
				selectionAct: [ :list | list selection inspect ] on: $i entitled: 'Inspect'.
		 ].

	browser transmit 
		from: #critics;
		to: #criticDetail;
		andShow: [ :a | 
			a text
				format: [ :critic | critic asString ].
		 ].
	
	^ browser
]

{ #category : #convenience }
FiLintRulesBrowser class >> openOn: rbEnvironment rules: rules [

	^ (self newBrowserOn: rbEnvironment) openOn: rules
]
