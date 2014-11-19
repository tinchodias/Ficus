Class {
	#name : #FiMethodDependencyInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'ringShotResource'
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
	
	ringShotResource := FiRGShotResource new
]

{ #category : #tests }
FiMethodDependencyInterpreterTest >> testClassASum [

	self 
		assertInterpretationOf: (
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #+;
				new)
		in: (ringShotResource classA >> #sum)
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
		in: (ringShotResource classA >> #sum42)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					ringShotResource classA >> #sum.
					ringShotResource classB >> #sum.
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
		in: (ringShotResource classB >> #defaultClass)
		equals: 
			(FiVariableBinding builder
				target: ringShotResource classC;
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
		in: (ringShotResource classB >> #sum)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					ringShotResource classA >> #sum.
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
		in: (ringShotResource classB >> #variableInSuper)
		equals: 
			(FiVariableBinding builder
				target: ringShotResource classA;
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
		in: (ringShotResource classC >> #sumAt:)
		equals: 
			(FiPossibleMethodInvocation builder
				methods: {
					ringShotResource classA >> #sum.
					ringShotResource classB >> #sum.
					ringShotResource classC >> #sum.
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
		in: (ringShotResource classC >> #undeclared)
		equals: FiVariableBinding undeclared
]
