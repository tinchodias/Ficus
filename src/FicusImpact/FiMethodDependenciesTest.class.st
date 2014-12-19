Class {
	#name : #FiMethodDependenciesTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiMethodDependenciesTest >> assertDependenciesOf: aRingMethod equals: dependencies [
	
	self 
		assert: aRingMethod ficusDependencies asSet 
		equals: dependencies asSet
]

{ #category : #running }
FiMethodDependenciesTest >> setUp [

	super setUp.
	
	resources := FiRGObjectResources new
]

{ #category : #tests }
FiMethodDependenciesTest >> testClassASum [

	self 
		assertDependenciesOf: resources classA >> #sum
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
FiMethodDependenciesTest >> testClassASum42 [

	self 
		assertDependenciesOf: resources classA >> #sum42
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
FiMethodDependenciesTest >> testClassBDefaultClass [

	self 
		assertDependenciesOf: resources classB >> #defaultClass
		equals: {
			FiVariableAccess builder
				variableName: #C;
				new
			}
]

{ #category : #tests }
FiMethodDependenciesTest >> testClassBSum [

	self 
		assertDependenciesOf: resources classB >> #sum
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
FiMethodDependenciesTest >> testClassBVariableInSuper [

	self 
		assertDependenciesOf: resources classB >> #variableInSuper
		equals: {
			FiVariableAccess builder
				variableName: #a1;
				new
			}
]

{ #category : #tests }
FiMethodDependenciesTest >> testClassCSum [

	self 
		assertDependenciesOf: resources classC >> #sum
		equals: { }
]

{ #category : #tests }
FiMethodDependenciesTest >> testClassCSumAt [

	self 
		assertDependenciesOf: resources classC >> #sumAt:
		equals: {
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #sum;
				new
		}

]

{ #category : #tests }
FiMethodDependenciesTest >> testClassCSumTmp [

	self 
		assertDependenciesOf: resources classC >> #sumTmp
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
FiMethodDependenciesTest >> testClassCUndeclared [

	self 
		assertDependenciesOf: resources classC >> #undeclared
		equals: {
			FiVariableAccess builder
				variableName: #undeclaredVar;
				new
		}
]
