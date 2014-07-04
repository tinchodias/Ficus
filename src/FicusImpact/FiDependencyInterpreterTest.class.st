Class {
	#name : #FiDependencyInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'ringShotResource'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiDependencyInterpreterTest >> assertInterpretationOf: aDependency in: aFiRGShot equals: anInterpretation [

	self 
		assert: 
			(FiDependencyInterpreter new 
				interpretationOf: aDependency 
				in: aFiRGShot)
		equals: anInterpretation
]

{ #category : #running }
FiDependencyInterpreterTest >> setUp [

	super setUp.
	
	ringShotResource := FiRGShotResource new
]

{ #category : #tests }
FiDependencyInterpreterTest >> testClassBDefaultClass [

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
FiDependencyInterpreterTest >> testClassBVariableInSuper [

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
