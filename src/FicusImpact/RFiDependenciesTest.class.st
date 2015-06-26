Class {
	#name : #RFiDependenciesTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
RFiDependenciesTest >> assertDependencyOf: aRequisite in: host targets: someTargets [

	| dependency |
	dependency := RFiRequisiteInterpreter new dependencyOf: aRequisite in: host.

	self assert: dependency requisite equals: aRequisite.
	self assert: dependency source equals: host.
	self assert: dependency targets equals: someTargets asFiSet.	
	self assert: (host ficusRequisites includes: aRequisite).
	
]

{ #category : #running }
RFiDependenciesTest >> setUp [

	super setUp.
	
	resources := RFiRingTestResources new
]

{ #category : #tests }
RFiDependenciesTest >> testClassA [

	self flag: #todo "test notFound".

	self 
		assertDependencyOf: (
			RFiInheritanceDeclaration builder
				theClassName: #A;
				new)
		in: resources ringClassB
		targets: { resources ringClassA }
]

{ #category : #tests }
RFiDependenciesTest >> testClassAInitialize [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources ringClassA classSide >> #initialize)
		targets: {resources ringClassA ringClassVariableNamed: #SomeClassVariable}

]

{ #category : #tests }
RFiDependenciesTest >> testClassASum [

	self 
		assertDependencyOf: (
			RFiMessageSend builder 
				receiver: RFiAnyMessageReceiver new;
				selector: #+;
				new)
		in: (resources ringClassA >> #sum)
		targets: 	{
			(resources ringEnvironment classNamed: #SmallInteger) >> #+.
			}
]

{ #category : #tests }
RFiDependenciesTest >> testClassASum42 [

	self 
		assertDependencyOf: (
			RFiMessageSend builder 
				receiver: RFiSelfMessageReceiver new;
				selector: #sum;
				new)
		in: (resources ringClassA >> #sum42)
		targets: {
			resources ringClassA >> #sum.
			resources ringClassB >> #sum.
			}
]

{ #category : #tests }
RFiDependenciesTest >> testClassASumVariableInSelf [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #a1;
				new)
		in: (resources ringClassA >> #sum)
		targets: {resources ringClassA ringInstanceVariableNamed: #a1}

]

{ #category : #tests }
RFiDependenciesTest >> testClassBDefaultClass [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #C;
				new)
		in: (resources ringClassB >> #defaultClass)
		targets: {resources ringClassC}
]

{ #category : #tests }
RFiDependenciesTest >> testClassBReadSomeClassVariable [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources ringClassB >> #readSomeClassVariable)
		targets: {resources ringClassA ringClassVariableNamed: #SomeClassVariable}

]

{ #category : #tests }
RFiDependenciesTest >> testClassBSum [

	self 
		assertDependencyOf: (
			RFiMessageSend builder 
				receiver: RFiSuperMessageReceiver new;
				selector: #sum;
				new)
		in: (resources ringClassB >> #sum)
		targets: {
			resources ringClassA >> #sum.
			}
]

{ #category : #tests }
RFiDependenciesTest >> testClassBVariableInSuper [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #a1;
				new)
		in: (resources ringClassB >> #variableInSuper)
		targets: {resources ringClassA ringInstanceVariableNamed: #a1}

]

{ #category : #tests }
RFiDependenciesTest >> testClassCSumAt [

	self 
		assertDependencyOf: (
			RFiMessageSend builder 
				receiver: RFiAnyMessageReceiver new;
				selector: #sum;
				new)
		in: (resources ringClassC >> #sumAt:)
		targets: {
			resources ringClassA >> #sum.
			resources ringClassB >> #sum.
			resources ringClassC >> #sum.
			resources ringTraitT1 >> #sum.
			}
]

{ #category : #tests }
RFiDependenciesTest >> testClassCUndeclared [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #undeclaredVar;
				new)
		in: (resources ringClassC >> #undeclared)
		targets: #()
]

{ #category : #tests }
RFiDependenciesTest >> testLinkedListAdd [

	| anEnvironment |
	anEnvironment := RFiBaseResources new ringEnvironment.
	self 
		assertDependencyOf: (
			RFiMessageSend builder 
				receiver: RFiAnyMessageReceiver new;
				selector: #ifTrue:ifFalse:;
				new)
		in: ((anEnvironment classNamed: #LinkedList) >> #add:)
		targets: {
			(anEnvironment classNamed: #True) >> #ifTrue:ifFalse:.
			(anEnvironment classNamed: #False) >> #ifTrue:ifFalse:.
			(anEnvironment classNamed: #Boolean) >> #ifTrue:ifFalse:.
			}.
				
	self flag: #todo. "Shouldn't include the one in Boolean, since #isProvided is false in such case."
]

{ #category : #tests }
RFiDependenciesTest >> testLinkedListRemovedFirst [

	| anEnvironment |
	anEnvironment := RFiBaseResources new ringEnvironment.
	self 
		assertDependencyOf: (
			RFiMessageSend builder 
				receiver: RFiSelfMessageReceiver new;
				selector: #isEmpty;
				new)
		in: ((anEnvironment classNamed: #LinkedList) >> #removeFirst)
		targets: {
			(anEnvironment classNamed: #Collection) >> #isEmpty.
			}
]

{ #category : #tests }
RFiDependenciesTest >> testObjectNew [

	self 
		assertDependencyOf: (
			RFiMessageSend builder 
				receiver: RFiSelfMessageReceiver new;
				selector: #basicNew;
				new)
		in: (resources ringEnvironment classNamed: #Object) classSide >> #new
		targets: {
			(resources ringEnvironment classNamed: #Object) classSide >> #basicNew.
			}
]
