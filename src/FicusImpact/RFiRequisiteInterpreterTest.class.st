Class {
	#name : #RFiRequisiteInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
RFiRequisiteInterpreterTest >> assertDependencyOf: aRequisite in: host targets: someTargets [

	| dependency |
	dependency := RFiRequisiteInterpreter new dependencyOf: aRequisite in: host.

	self assert: dependency requisite equals: aRequisite.
	self assert: dependency source equals: host.
	self assert: dependency targets equals: someTargets asFiSet.	
	self assert: (host ficusRequisites includes: aRequisite).
	
]

{ #category : #running }
RFiRequisiteInterpreterTest >> setUp [

	super setUp.
	
	resources := RFiRingTestResources new
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassA [

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
RFiRequisiteInterpreterTest >> testClassAInitialize [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources ringClassA classSide >> #initialize)
		targets: {resources ringClassA ringClassVariableNamed: #SomeClassVariable}

]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassASum [

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
RFiRequisiteInterpreterTest >> testClassASum42 [

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
RFiRequisiteInterpreterTest >> testClassASumVariableInSelf [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #a1;
				new)
		in: (resources ringClassA >> #sum)
		targets: {resources ringClassA ringInstanceVariableNamed: #a1}

]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassBDefaultClass [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #C;
				new)
		in: (resources ringClassB >> #defaultClass)
		targets: {resources ringClassC}
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassBReadSomeClassVariable [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources ringClassB >> #readSomeClassVariable)
		targets: {resources ringClassA ringClassVariableNamed: #SomeClassVariable}

]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassBSum [

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
RFiRequisiteInterpreterTest >> testClassBVariableInSuper [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #a1;
				new)
		in: (resources ringClassB >> #variableInSuper)
		targets: {resources ringClassA ringInstanceVariableNamed: #a1}

]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassCSumAt [

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
			}
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassCUndeclared [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #undeclaredVar;
				new)
		in: (resources ringClassC >> #undeclared)
		targets: #()
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testLinkedListAdd [

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
RFiRequisiteInterpreterTest >> testLinkedListRemovedFirst [

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
RFiRequisiteInterpreterTest >> testObjectNew [

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
