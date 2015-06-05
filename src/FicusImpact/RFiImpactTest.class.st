"
A RFiImpactTest is a test class for testing the behavior of RFiImpact
"
Class {
	#name : #RFiImpactTest,
	#superclass : #TestCase,
	#category : #'FicusImpact-Tests'
}

{ #category : #'as yet unclassified' }
RFiImpactTest >> impacts2From: oldRFiObject to: newRFiObject [ 

	| oldDependencies newDependencies diff |
	oldDependencies := oldRFiObject ficusDependencies.
	newDependencies := newRFiObject ficusDependencies.

	diff := (newDependencies collect: #asRFiInterpretedDependency) asFiSet
		differenceFrom: (oldDependencies collect: #asRFiInterpretedDependency) asFiSet.

	^ diff asSimpleEffects collect: [ :aSimpleEffect |
		self impactOf: aSimpleEffect from: oldDependencies to: newDependencies.
		 ]
]

{ #category : #'as yet unclassified' }
RFiImpactTest >> impactsFrom: oldRFiObject to: newRFiObject [ 

	| oldDependencies newDependencies requisitesWithImpact |
	oldDependencies := oldRFiObject ficusDependencies.
	newDependencies := newRFiObject ficusDependencies.

	requisitesWithImpact := self requisitesWithImpactFrom: oldDependencies to: newDependencies.

	^ requisitesWithImpact collect: [ :aRequisite |
		RFiImpact new
			oldDependency: 
				(oldDependencies 
					detect: [ :each | each requisite = aRequisite ]
					ifNone: [ nil ]);
			newDependency:
				(newDependencies 
					detect: [ :each | each requisite = aRequisite ]
					ifNone: [ nil ]);
			yourself ].

]

{ #category : #'as yet unclassified' }
RFiImpactTest >> requisitesWithImpactFrom: oldDependencies to: newDependencies [ 

	| diff |
	diff := (newDependencies collect: #asRFiInterpretedDependency) asFiSet
		differenceFrom: (oldDependencies collect: #asRFiInterpretedDependency) asFiSet.

	^ diff asSimpleEffects collect: [ :aSimpleEffect |
		aSimpleEffect oldValue requisite ].

]

{ #category : #'as yet unclassified' }
RFiImpactTest >> test01 [

	| pkg1 pkg2 env1 env2 impacts old new |
	pkg1 := RFiFragileBaseClassProblemResources5A new packageLoggers.

	pkg2 := pkg1 resultOf: (
			FiSubEdit
				path: #(contents Log methods log: sourceCode) asFiPath
				equal: 'log: aMessage  
		collection addFirst: aMessage').

	env1 := (RFiBaseResources new ficusEnvironment packages copyWith: pkg1) asRFiEnvironment.
	env2 := (RFiBaseResources new ficusEnvironment packages copyWith: pkg2) asRFiEnvironment.

	old := (env1 classNamed: #FilteredLogTest) >> #testLog.
	new := (env2 classNamed: #FilteredLogTest) >> #testLog.
	
	impacts := self 
		impactsFrom: old
		to: new.
	
	self deny: impacts isEmpty.
	
"	impacts inspect."
]
