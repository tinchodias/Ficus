Class {
	#name : #FiLintRulesTest,
	#superclass : #TestCase,
	#category : #'FicusRing-AST'
}

{ #category : #resources }
FiLintRulesTest >> newRule [
			
	^ RBCompositeLintRule rules: (self ruleClasses collect: #new)
]

{ #category : #resources }
FiLintRulesTest >> ruleClasses [ 

	^  { 
		RBClassVariableCapitalizationRule.
		RBDefinesEqualNotHashRule.
		RBExcessiveInheritanceRule.
		RBExcessiveMethodsRule.
		RBExcessiveVariablesRule.
		RBClassInstVarNotInitializedRule.
		RBInstanceVariableCapitalizationRule.
		RBTempVarOverridesInstVarRule.
		RBInstVarInSubclassesRule.
		RBSentNotImplementedRule.
		RBMissingSubclassResponsibilityRule.
		RBEquivalentSuperclassMethodsRule.
		RBImplementedNotSentRule.
		RBNoClassCommentRule. }
]

{ #category : #tests }
FiLintRulesTest >> testRunRule [
			
	| rule |
	rule := self newRule.

	RBSmalllintChecker 
		runRule: rule
		onEnvironment: (FiRBBrowserEnvironment new environment: FiFragileBaseProblemResources new environmentInitial asFiRGEnvironment).
		
	self flag: #fix.
	self assert: rule problemCount equals: 7.
]
