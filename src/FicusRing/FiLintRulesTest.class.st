Class {
	#name : #FiLintRulesTest,
	#superclass : #TestCase,
	#category : #'FicusRing-Tests'
}

{ #category : #resources }
FiLintRulesTest >> newRule [

	self flag: #todo.

	^ RBCompositeLintRule allGoodRules
		removeRule: RBVariableNotDefinedRule new; 
		removeRule: RBLiteralArrayContainsSuspiciousTrueFalseOrNilRule new; "it checks compilation"
		removeRule: RBUnpackagedCodeRule new; "it access managers directly; anyway, we don't have unpackaged for the moment."
		yourself
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
		onEnvironment: (FiRBBrowserEnvironment new environment: RFiFragileBaseClassProblemResources3 new ringEnvironment).
		
	self flag: #fix.
	self assert: rule problemCount equals: 67.
]
