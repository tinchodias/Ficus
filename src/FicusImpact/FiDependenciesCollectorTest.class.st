Class {
	#name : #FiDependenciesCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'ringShotResource'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiDependenciesCollectorTest >> assertDependenciesOf: aRingMethod equals: dependencies [
	
	self 
		assert: (FiDependenciesCollector new dependenciesFor: aRingMethod) asSet 
		equals: dependencies asSet
]

{ #category : #running }
FiDependenciesCollectorTest >> setUp [

	super setUp.
	
	ringShotResource := FiRGShotResource new
]

{ #category : #tests }
FiDependenciesCollectorTest >> testClassASum [

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
FiDependenciesCollectorTest >> testClassASum42 [

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
FiDependenciesCollectorTest >> testClassBDefaultClass [

	self 
		assertDependenciesOf: ringShotResource classB >> #defaultClass
		equals: {
			FiVariableAccess builder
				variableName: #C;
				new
			}
]

{ #category : #tests }
FiDependenciesCollectorTest >> testClassBSum [

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
FiDependenciesCollectorTest >> testClassBVariableInSuper [

	self 
		assertDependenciesOf: ringShotResource classB >> #variableInSuper
		equals: {
			FiVariableAccess builder
				variableName: #a1;
				new
			}
]

{ #category : #tests }
FiDependenciesCollectorTest >> testClassCSum [

	self 
		assertDependenciesOf: ringShotResource classC >> #sum
		equals: { }
]

{ #category : #tests }
FiDependenciesCollectorTest >> testClassCUndeclared [

	self 
		assertDependenciesOf: ringShotResource classC >> #undeclared
		equals: {
			FiVariableAccess builder
				variableName: #undeclaredVar;
				new
		}
]
