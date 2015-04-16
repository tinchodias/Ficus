Class {
	#name : #RFiRequisiteInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
RFiRequisiteInterpreterTest >> assertDependencyOf: aRequisite in: host equals: aDependency [

	self 
		assert: 
			(RFiRequisiteInterpreter new 
				dependencyOf: aRequisite 
				in: host)
		equals: aDependency.
		
	self assert: (host ficusRequisites includes: aRequisite).
	
]

{ #category : #running }
RFiRequisiteInterpreterTest >> setUp [

	super setUp.
	
	resources := RFiRingTestResources new
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassA [

	self flag: #todo "#notFound?".

	self 
		assertDependencyOf: (
			RFiInheritanceDeclaration builder
				theClassName: #A;
				new)
		in: resources ringClassB
		equals: (RFiInheritance builder target: resources ringClassA; new)
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassAInitialize [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources ringClassA classSide >> #initialize)
		equals: 
			(RFiVariableBinding builder
				target: (resources ringClassA ringClassVariableNamed: #SomeClassVariable);
				new)

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
		equals: (
			RFiPossibleMethodInvocation builder
				methods: {
					(resources ringEnvironment classNamed: #SmallInteger) >> #+.
					} asFiSet;
				new)
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
		equals: 
			(RFiPossibleMethodInvocation builder
				methods: {
					resources ringClassA >> #sum.
					resources ringClassB >> #sum.
					} asFiSet;
				new)
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassASumVariableInSelf [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #a1;
				new)
		in: (resources ringClassA >> #sum)
		equals: 
			(RFiVariableBinding builder
				target: (resources ringClassA ringInstanceVariableNamed: #a1);
				new)

]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassBDefaultClass [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #C;
				new)
		in: (resources ringClassB >> #defaultClass)
		equals: 
			(RFiVariableBinding builder
				target: resources ringClassC;
				new)
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassBReadSomeClassVariable [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources ringClassB >> #readSomeClassVariable)
		equals: 
			(RFiVariableBinding builder
				target: (resources ringClassA ringClassVariableNamed: #SomeClassVariable);
				new)

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
		equals: 
			(RFiPossibleMethodInvocation builder
				methods: {
					resources ringClassA >> #sum.
					} asFiSet;
				new)
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassBVariableInSuper [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #a1;
				new)
		in: (resources ringClassB >> #variableInSuper)
		equals: 
			(RFiVariableBinding builder
				target: (resources ringClassA ringInstanceVariableNamed: #a1);
				new)

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
		equals: 
			(RFiPossibleMethodInvocation builder
				methods: {
					resources ringClassA >> #sum.
					resources ringClassB >> #sum.
					resources ringClassC >> #sum.
					} asFiSet;
				new)
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testClassCUndeclared [

	self 
		assertDependencyOf: (
			RFiVariableAccess builder
				variableName: #undeclaredVar;
				new)
		in: (resources ringClassC >> #undeclared)
		equals: RFiVariableBinding undeclared
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
		equals: 
			(RFiPossibleMethodInvocation builder
				methods: {
					(anEnvironment classNamed: #True) >> #ifTrue:ifFalse:.
					(anEnvironment classNamed: #False) >> #ifTrue:ifFalse:.
					(anEnvironment classNamed: #Boolean) >> #ifTrue:ifFalse:.
					} asFiSet;
				new).
				
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
		equals: 
			(RFiPossibleMethodInvocation builder
				methods: {
					(anEnvironment classNamed: #Collection) >> #isEmpty.
					} asFiSet;
				new)
]

{ #category : #tests }
RFiRequisiteInterpreterTest >> testObjectNew [

	self 
		assertDependencyOf: (
			RFiMessageSend builder 
				receiver: RFiSelfMessageReceiver new;
				selector: #basicNew;
				new)
		in: ((resources ringEnvironment classNamed: #Object) classSide >> #new)
		equals: 
			(RFiPossibleMethodInvocation builder
				methods: {
					(resources ringEnvironment classNamed: #Object) classSide >> #basicNew.
					} asFiSet;
				new)
]
