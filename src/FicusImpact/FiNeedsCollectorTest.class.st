Class {
	#name : #FiNeedsCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'ringShotResource'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiNeedsCollectorTest >> assertNeedsOf: aRingMethod equals: aNeed [
	
	self 
		assert: (FiDependenciesCollector new dependenciesFor: aRingMethod) asSet 
		equals: aNeed asSet
]

{ #category : #running }
FiNeedsCollectorTest >> setUp [

	super setUp.
	
	ringShotResource := FiRGShotResource new
]

{ #category : #tests }
FiNeedsCollectorTest >> testClassASum [

	self 
		assertNeedsOf: ringShotResource classA >> #sum
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
FiNeedsCollectorTest >> testClassASum42 [

	self 
		assertNeedsOf: ringShotResource classA >> #sum42
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
FiNeedsCollectorTest >> testClassBDefaultClass [

	self 
		assertNeedsOf: ringShotResource classB >> #defaultClass
		equals: {
			FiVariableAccess builder
				variableName: #C;
				new
			}
]

{ #category : #tests }
FiNeedsCollectorTest >> testClassBSum [

	self 
		assertNeedsOf: ringShotResource classB >> #sum
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
FiNeedsCollectorTest >> testClassBVariableInSuper [

	self 
		assertNeedsOf: ringShotResource classB >> #variableInSuper
		equals: {
			FiVariableAccess builder
				variableName: #a1;
				new
			}
]

{ #category : #tests }
FiNeedsCollectorTest >> testClassCSum [

	self 
		assertNeedsOf: ringShotResource classC >> #sum
		equals: { }
]

{ #category : #tests }
FiNeedsCollectorTest >> testClassCUndeclared [

	self 
		assertNeedsOf: ringShotResource classC >> #undeclared
		equals: {
			FiVariableAccess builder
				variableName: #undeclaredVar;
				new
		}
]
