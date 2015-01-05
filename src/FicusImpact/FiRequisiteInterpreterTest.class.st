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
		equals: aDependency
]

{ #category : #running }
FiRequisiteInterpreterTest >> setUp [

	super setUp.
	
	resources := FiRGObjectRingTestResources new
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassA [

	self flag: #todo "#notFound?".

	self 
		assertDependencyOf: (
			FiInheritanceDeclaration builder
				theClassName: #A;
				new)
		in: resources classB
		equals: (FiInheritance builder target: resources classA; new)
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassAInitialize [

	self 
		assertDependencyOf: (
			FiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources classA classSide >> #initialize)
		equals: 
			(FiVariableBinding builder
				target: resources classA;
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
		in: (resources classA >> #sum)
		equals: (
			FiPossibleMethodInvocation builder
				methods: {
					(resources environmentWithAll classNamed: #SmallInteger) >> #+.
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
		in: (resources classA >> #sum42)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					resources classA >> #sum.
					resources classB >> #sum.
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
		in: (resources classA >> #sum)
		equals: 
			(FiVariableBinding builder
				target: resources classA;
				new)

]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassBDefaultClass [

	self 
		assertDependencyOf: (
			FiVariableAccess builder
				variableName: #C;
				new)
		in: (resources classB >> #defaultClass)
		equals: 
			(FiVariableBinding builder
				target: resources classC;
				new)
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testClassBReadSomeClassVariable [

	self 
		assertDependencyOf: (
			FiVariableAccess builder
				variableName: #SomeClassVariable;
				new)
		in: (resources classB >> #readSomeClassVariable)
		equals: 
			(FiVariableBinding builder
				target: resources classA;
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
		in: (resources classB >> #sum)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					resources classA >> #sum.
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
		in: (resources classB >> #variableInSuper)
		equals: 
			(FiVariableBinding builder
				target: resources classA;
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
		in: (resources classC >> #sumAt:)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					resources classA >> #sum.
					resources classB >> #sum.
					resources classC >> #sum.
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
		in: (resources classC >> #undeclared)
		equals: FiVariableBinding undeclared
]

{ #category : #tests }
FiRequisiteInterpreterTest >> testLinkedListRemovedFirst [

	| anEnvironment |
	anEnvironment := FiFragileBaseProblemResources new environmentWithAll asFiRGEnvironment.
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
		in: ((resources environmentWithAll classNamed: #Object) classSide >> #new)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					(resources environmentWithAll classNamed: #Object) classSide >> #basicNew.
					} asFiSet;
				new)
]
