Class {
	#name : #FiMethodRequisitesTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiMethodRequisitesTest >> assertRequisitesOf: aRingMethod equals: dependencies [
	
	self 
		assert: aRingMethod ficusRequisites asSet 
		equals: dependencies asSet
]

{ #category : #running }
FiMethodRequisitesTest >> setUp [

	super setUp.
	
	resources := FiRingTestResources new
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassAClassInitialize [

	self 
		assertRequisitesOf: resources ringClassA classSide >> #initialize
		equals: {
			FiVariableAccess builder
				variableName: #SomeClassVariable;
				new.
			FiVariableAccess builder
				variableName: #a3;
				new.
			FiVariableAccess builder
				variableName: #A;
				new.
			FiMessageSend builder
				receiver: FiAnyMessageReceiver new;
				selector: #new;
				new
				}
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassASum [

	self 
		assertRequisitesOf: resources ringClassA >> #sum
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
FiMethodRequisitesTest >> testClassASum42 [

	self 
		assertRequisitesOf: resources ringClassA >> #sum42
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
FiMethodRequisitesTest >> testClassBDefaultClass [

	self 
		assertRequisitesOf: resources ringClassB >> #defaultClass
		equals: {
			FiVariableAccess builder
				variableName: #C;
				new
			}
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassBReadSomeClassVariable [

	self 
		assertRequisitesOf: resources ringClassB >> #readSomeClassVariable
		equals: {
			FiVariableAccess builder
				variableName: #SomeClassVariable;
				new
			}
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassBSum [

	self 
		assertRequisitesOf: resources ringClassB >> #sum
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
FiMethodRequisitesTest >> testClassBVariableInSuper [

	self 
		assertRequisitesOf: resources ringClassB >> #variableInSuper
		equals: {
			FiVariableAccess builder
				variableName: #a1;
				new
			}
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassCSum [

	self 
		assertRequisitesOf: resources ringClassC >> #sum
		equals: { }
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassCSumAt [

	self 
		assertRequisitesOf: resources ringClassC >> #sumAt:
		equals: {
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #sum;
				new
		}

]

{ #category : #tests }
FiMethodRequisitesTest >> testClassCSumTmp [

	self 
		assertRequisitesOf: resources ringClassC >> #sumTmp
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
FiMethodRequisitesTest >> testClassCUndeclared [

	self 
		assertRequisitesOf: resources ringClassC >> #undeclared
		equals: {
			FiVariableAccess builder
				variableName: #undeclaredVar;
				new
		}
]
