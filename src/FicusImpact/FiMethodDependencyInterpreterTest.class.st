Class {
	#name : #FiMethodDependencyInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiMethodDependencyInterpreterTest >> assertInterpretationOf: aDependency in: aFiRGShot equals: anInterpretation [

	self 
		assert: 
			(FiMethodDependencyInterpreter new 
				interpretationOf: aDependency 
				in: aFiRGShot)
		equals: anInterpretation
]

{ #category : #running }
FiMethodDependencyInterpreterTest >> setUp [

	super setUp.
	
	resources := FiRGObjectResources new
]

{ #category : #tests }
FiMethodDependencyInterpreterTest >> testClassASum [

	self 
		assertInterpretationOf: (
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #+;
				new)
		in: (resources classA >> #sum)
		equals: FiPossibleMethodInvocation empty
]

{ #category : #tests }
FiMethodDependencyInterpreterTest >> testClassASum42 [

	self 
		assertInterpretationOf: (
			FiMessageSend builder 
				receiver: (FiSelfMessageReceiver builder behaviorName: #A; new);
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
FiMethodDependencyInterpreterTest >> testClassBDefaultClass [

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
FiMethodDependencyInterpreterTest >> testClassBSum [

	self 
		assertInterpretationOf: (
			FiMessageSend builder 
				receiver: (FiSuperMessageReceiver builder behaviorName: #B; new);
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
FiMethodDependencyInterpreterTest >> testClassBVariableInSuper [

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
FiMethodDependencyInterpreterTest >> testClassCSumAt [

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
FiMethodDependencyInterpreterTest >> testClassCUndeclared [

	self 
		assertInterpretationOf: (
			FiVariableAccess builder
				variableName: #undeclaredVar;
				new)
		in: (resources classC >> #undeclared)
		equals: FiVariableBinding undeclared
]
