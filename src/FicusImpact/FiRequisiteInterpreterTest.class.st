Class {
	#name : #FiRequisiteInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiRequisiteInterpreterTest >> assertDependencyOf: aRequisite in: host equals: aDependency [

	self 
		assert: 
			(FiRequisiteInterpreter new 
				dependencyOf: aRequisite 
				in: host)
		equals: aDependency.
		
	self assert: (host ficusRequisites includes: aRequisite).
	
]

{ #category : #running }
FiRequisiteInterpreterTest >> setUp [

	super setUp.
	
	resources := RFiRingTestResources new
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassA [

	self flag: #todo "#notFound?".

	self 
		assertDependencyOf: (
			FiInheritanceDeclaration builder
				theClassName: #A;
				new)
		in: resources ringClassB
		equals: (FiInheritance builder target: resources ringClassA; new)
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassAInitialize [

	self 
		assertDependencyOf: (
			FiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources ringClassA classSide >> #initialize)
		equals: 
			(FiVariableBinding builder
				target: (resources ringClassA ringClassVariableNamed: #SomeClassVariable);
				new)

]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassASum [

	self 
		assertDependencyOf: (
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #+;
				new)
		in: (resources ringClassA >> #sum)
		equals: (
			FiPossibleMethodInvocation builder
				methods: {
					(resources ficusRGEnvironment classNamed: #SmallInteger) >> #+.
					} asFiSet;
				new)
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassASum42 [

	self 
		assertDependencyOf: (
			FiMessageSend builder 
				receiver: FiSelfMessageReceiver new;
				selector: #sum;
				new)
		in: (resources ringClassA >> #sum42)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					resources ringClassA >> #sum.
					resources ringClassB >> #sum.
					} asFiSet;
				new)
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassASumVariableInSelf [

	self 
		assertDependencyOf: (
			FiVariableAccess builder
				variableName: #a1;
				new)
		in: (resources ringClassA >> #sum)
		equals: 
			(FiVariableBinding builder
				target: (resources ringClassA ringInstanceVariableNamed: #a1);
				new)

]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassBDefaultClass [

	self 
		assertDependencyOf: (
			FiVariableAccess builder
				variableName: #C;
				new)
		in: (resources ringClassB >> #defaultClass)
		equals: 
			(FiVariableBinding builder
				target: resources ringClassC;
				new)
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassBReadSomeClassVariable [

	self 
		assertDependencyOf: (
			FiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources ringClassB >> #readSomeClassVariable)
		equals: 
			(FiVariableBinding builder
				target: (resources ringClassA ringClassVariableNamed: #SomeClassVariable);
				new)

]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassBSum [

	self 
		assertDependencyOf: (
			FiMessageSend builder 
				receiver: FiSuperMessageReceiver new;
				selector: #sum;
				new)
		in: (resources ringClassB >> #sum)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					resources ringClassA >> #sum.
					} asFiSet;
				new)
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassBVariableInSuper [

	self 
		assertDependencyOf: (
			FiVariableAccess builder
				variableName: #a1;
				new)
		in: (resources ringClassB >> #variableInSuper)
		equals: 
			(FiVariableBinding builder
				target: (resources ringClassA ringInstanceVariableNamed: #a1);
				new)

]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassCSumAt [

	self 
		assertDependencyOf: (
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #sum;
				new)
		in: (resources ringClassC >> #sumAt:)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					resources ringClassA >> #sum.
					resources ringClassB >> #sum.
					resources ringClassC >> #sum.
					} asFiSet;
				new)
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassCUndeclared [

	self 
		assertDependencyOf: (
			FiVariableAccess builder
				variableName: #undeclaredVar;
				new)
		in: (resources ringClassC >> #undeclared)
		equals: FiVariableBinding undeclared
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testLinkedListAdd [

	| anEnvironment |
	anEnvironment := RFiBaseResources new ficusRGEnvironment.
	self 
		assertDependencyOf: (
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #ifTrue:ifFalse:;
				new)
		in: ((anEnvironment classNamed: #LinkedList) >> #add:)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					(anEnvironment classNamed: #True) >> #ifTrue:ifFalse:.
					(anEnvironment classNamed: #False) >> #ifTrue:ifFalse:.
					(anEnvironment classNamed: #Boolean) >> #ifTrue:ifFalse:.
					} asFiSet;
				new).
				
	self flag: #todo. "Shouldn't include the one in Boolean, since #isProvided is false in such case."
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testLinkedListRemovedFirst [

	| anEnvironment |
	anEnvironment := RFiBaseResources new ficusRGEnvironment.
	self 
		assertDependencyOf: (
			FiMessageSend builder 
				receiver: FiSelfMessageReceiver new;
				selector: #isEmpty;
				new)
		in: ((anEnvironment classNamed: #LinkedList) >> #removeFirst)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					(anEnvironment classNamed: #Collection) >> #isEmpty.
					} asFiSet;
				new)
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testObjectNew [

	self 
		assertDependencyOf: (
			FiMessageSend builder 
				receiver: FiSelfMessageReceiver new;
				selector: #basicNew;
				new)
		in: ((resources ficusRGEnvironment classNamed: #Object) classSide >> #new)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					(resources ficusRGEnvironment classNamed: #Object) classSide >> #basicNew.
					} asFiSet;
				new)
]
