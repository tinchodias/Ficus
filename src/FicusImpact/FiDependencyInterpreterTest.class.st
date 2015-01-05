Class {
	#name : #FiDependencyInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiDependencyInterpreterTest >> assertInterpretationOf: aDependency in: aFiRGMethod equals: anInterpretation [

	self 
		assert: 
			(FiDependencyInterpreter new 
				interpretationOf: aDependency 
				in: aFiRGMethod)
		equals: anInterpretation
]

{ #category : #running }
FiDependencyInterpreterTest >> setUp [

	super setUp.
	
	resources := FiRGObjectRingTestResources new
]

{ #category : #tests }
FiDependencyInterpreterTest >> testClassA [

	self flag: #todo "#notFound?".

	self 
		assertInterpretationOf: (
			FiInheritanceDeclaration builder
				theClassName: #A;
				new)
		in: resources classB
		equals: (FiInheritance builder target: resources classA; new)
]

{ #category : #tests }
FiDependencyInterpreterTest >> testClassAInitialize [

	self 
		assertInterpretationOf: (
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
FiDependencyInterpreterTest >> testClassASum [

	self 
		assertInterpretationOf: (
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
FiDependencyInterpreterTest >> testClassASum42 [

	self 
		assertInterpretationOf: (
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
FiDependencyInterpreterTest >> testClassASumVariableInSelf [

	self 
		assertInterpretationOf: (
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
FiDependencyInterpreterTest >> testClassBDefaultClass [

	self 
		assertInterpretationOf: (
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
FiDependencyInterpreterTest >> testClassBReadSomeClassVariable [

	self 
		assertInterpretationOf: (
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
FiDependencyInterpreterTest >> testClassBSum [

	self 
		assertInterpretationOf: (
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
FiDependencyInterpreterTest >> testClassBVariableInSuper [

	self 
		assertInterpretationOf: (
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
FiDependencyInterpreterTest >> testClassCSumAt [

	self 
		assertInterpretationOf: (
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
FiDependencyInterpreterTest >> testClassCUndeclared [

	self 
		assertInterpretationOf: (
			FiVariableAccess builder
				variableName: #undeclaredVar;
				new)
		in: (resources classC >> #undeclared)
		equals: FiVariableBinding undeclared
]
