Class {
	#name : #FiMethodDependencyInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'ringObjectResource'
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
	
	ringObjectResource := FiRGObjectResource new
]

{ #category : #tests }
FiMethodDependencyInterpreterTest >> testClassASum [

	self 
		assertInterpretationOf: (
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #+;
				new)
		in: (ringObjectResource classA >> #sum)
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
		in: (ringObjectResource classA >> #sum42)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					ringObjectResource classA >> #sum.
					ringObjectResource classB >> #sum.
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
		in: (ringObjectResource classB >> #defaultClass)
		equals: 
			(FiVariableBinding builder
				target: ringObjectResource classC;
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
		in: (ringObjectResource classB >> #sum)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					ringObjectResource classA >> #sum.
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
		in: (ringObjectResource classB >> #variableInSuper)
		equals: 
			(FiVariableBinding builder
				target: ringObjectResource classA;
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
		in: (ringObjectResource classC >> #sumAt:)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					ringObjectResource classA >> #sum.
					ringObjectResource classB >> #sum.
					ringObjectResource classC >> #sum.
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
		in: (ringObjectResource classC >> #undeclared)
		equals: FiVariableBinding undeclared
]
