Class {
	#name : #FiMethodDependenciesCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'ringShotResource'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiMethodDependenciesCollectorTest >> assertDependenciesOf: aRingMethod equals: dependencies [
	
	self 
		assert: (FiMethodDependenciesCollector new dependenciesFor: aRingMethod) asSet 
		equals: dependencies asSet
]

{ #category : #running }
FiMethodDependenciesCollectorTest >> setUp [

	super setUp.
	
	ringShotResource := FiRGShotResource new
]

{ #category : #tests }
FiMethodDependenciesCollectorTest >> testClassASum [

	self 
		assertDependenciesOf: ringShotResource classA >> #sum
		equals: {
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #+;
				new.
			FiVariableAccess builder
				variableName: #a1;
				new.
			FiVariableAccess builder
				variableName: #a2;
				new
			}
]

{ #category : #tests }
FiMethodDependenciesCollectorTest >> testClassASum42 [

	self 
		assertDependenciesOf: ringShotResource classA >> #sum42
		equals: {
			FiMessageSend builder 
				receiver: FiSelfMessageReceiver new;
				selector: #sum;
				new.
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #+;
				new.
			}
]

{ #category : #tests }
FiMethodDependenciesCollectorTest >> testClassBDefaultClass [

	self 
		assertDependenciesOf: ringShotResource classB >> #defaultClass
		equals: {
			FiVariableAccess builder
				variableName: #C;
				new
			}
]

{ #category : #tests }
FiMethodDependenciesCollectorTest >> testClassBSum [

	self 
		assertDependenciesOf: ringShotResource classB >> #sum
		equals: {
			FiMessageSend builder 
				receiver: FiSuperMessageReceiver new;
				selector: #sum;
				new.
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #+;
				new.
			FiVariableAccess builder
				variableName: #b1;
				new
			}
]

{ #category : #tests }
FiMethodDependenciesCollectorTest >> testClassBVariableInSuper [

	self 
		assertDependenciesOf: ringShotResource classB >> #variableInSuper
		equals: {
			FiVariableAccess builder
				variableName: #a1;
				new
			}
]

{ #category : #tests }
FiMethodDependenciesCollectorTest >> testClassCSum [

	self 
		assertDependenciesOf: ringShotResource classC >> #sum
		equals: { }
]

{ #category : #tests }
FiMethodDependenciesCollectorTest >> testClassCSumAt [

	self 
		assertDependenciesOf: ringShotResource classC >> #sumAt:
		equals: {
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #sum;
				new
		}

]

{ #category : #tests }
FiMethodDependenciesCollectorTest >> testClassCUndeclared [

	self 
		assertDependenciesOf: ringShotResource classC >> #undeclared
		equals: {
			FiVariableAccess builder
				variableName: #undeclaredVar;
				new
		}
]
