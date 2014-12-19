"
I am a RBBrowserEnvironment for Ficus.

Raw example:

interestingRules := { 
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
		RBNoClassCommentRule. } collect: #new.
			
""	excludedRules := { 
		#RBClassNotReferencedRule. 
		#RBExplicitRequirementMethodsRule.
		#RBAddRemoveDependentsRule.
		#RBLiteralArrayContainsCommaRule.
		#RBLiteralArrayContainsSuspiciousTrueFalseOrNilRule.
		#RBMethodHasNoTimeStampRule.
		#RBOnlyReadOrWrittenVariableRule.
		#RBOverridesSpecialMessageRule. 
		#RBInconsistentMethodClassificationRule }.
	rules := (RBCompositeLintRule rulesFor: RBBasicLintRule)
		reject: [ :each | excludedRules includes: each className ].
	someRules := rules first: 41.
""
	RBSmalllintChecker 
		runRule: (RBCompositeLintRule rules: interestingRules)
		onEnvironment: (FiRBBrowserEnvironment new ringEnvironment: environment).
"
Class {
	#name : #FiRBBrowserEnvironment,
	#superclass : #RBBrowserEnvironment,
	#instVars : [
		'environment'
	],
	#category : #'FicusRing-AST'
}

{ #category : #'accessing-classes' }
FiRBBrowserEnvironment >> at: aKey ifAbsent: aBlock [

	^ environment 
		at: aKey
		ifAbsent: aBlock
]

{ #category : #private }
FiRBBrowserEnvironment >> defaultLabel [

	^ 'Ficus RB Environment'
]

{ #category : #accessing }
FiRBBrowserEnvironment >> environment: anObject [

	environment := anObject
]

{ #category : #private }
FiRBBrowserEnvironment >> systemDictionary [

	^ environment
]
