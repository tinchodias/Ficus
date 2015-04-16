Class {
	#name : #RFiMethodRequisitesTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
RFiMethodRequisitesTest >> assertRequisitesOf: aRingMethod equals: dependencies [
	
	self 
		assert: aRingMethod ficusRequisites asSet 
		equals: dependencies asSet
]

{ #category : #running }
RFiMethodRequisitesTest >> setUp [

	super setUp.
	
	resources := RFiRingTestResources new
]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassAClassInitialize [

	self 
		assertRequisitesOf: resources ringClassA classSide >> #initialize
		equals: {
			RFiVariableAccess builder
				variableName: #SomeSharedPoolVariable;
				new.
			RFiVariableAccess builder
				variableName: #SomeClassVariable;
				new.
			RFiVariableAccess builder
				variableName: #a3;
				new.
			RFiVariableAccess builder
				variableName: #A;
				new.
			RFiMessageSend builder
				receiver: RFiAnyMessageReceiver new;
				selector: #new;
				new.
				}
]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassASum [

	self 
		assertRequisitesOf: resources ringClassA >> #sum
		equals: {
			RFiMessageSend builder 
				receiver: RFiAnyMessageReceiver new;
				selector: #+;
				new.
			RFiVariableAccess builder
				variableName: #a1;
				new.
			RFiVariableAccess builder
				variableName: #a2;
				new.
			}
]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassASum42 [

	self 
		assertRequisitesOf: resources ringClassA >> #sum42
		equals: {
			RFiMessageSend builder 
				receiver: RFiSelfMessageReceiver new;
				selector: #sum;
				new.
			RFiMessageSend builder 
				receiver: RFiAnyMessageReceiver new;
				selector: #+;
				new.
			}
]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassBDefaultClass [

	self 
		assertRequisitesOf: resources ringClassB >> #defaultClass
		equals: {
			RFiVariableAccess builder
				variableName: #C;
				new.
			}
]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassBReadSomeClassVariable [

	self 
		assertRequisitesOf: resources ringClassB >> #readSomeClassVariable
		equals: {
			RFiVariableAccess builder
				variableName: #SomeClassVariable;
				new.
			}
]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassBSum [

	self 
		assertRequisitesOf: resources ringClassB >> #sum
		equals: {
			RFiMessageSend builder 
				receiver: RFiSuperMessageReceiver new;
				selector: #sum;
				new.
			RFiMessageSend builder 
				receiver: RFiAnyMessageReceiver new;
				selector: #+;
				new.
			RFiVariableAccess builder
				variableName: #b1;
				new.
			}
]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassBVariableInSuper [

	self 
		assertRequisitesOf: resources ringClassB >> #variableInSuper
		equals: {
			RFiVariableAccess builder
				variableName: #a1;
				new.
			}
]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassCSum [

	self 
		assertRequisitesOf: resources ringClassC >> #sum
		equals: {}
]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassCSumAt [

	self 
		assertRequisitesOf: resources ringClassC >> #sumAt:
		equals: {
			RFiMessageSend builder 
				receiver: RFiAnyMessageReceiver new;
				selector: #sum;
				new.
		}

]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassCSumTmp [

	self 
		assertRequisitesOf: resources ringClassC >> #sumTmp
		equals: {
			RFiMessageSend builder 
				receiver: RFiSelfMessageReceiver new;
				selector: #sum;
				new.
			RFiMessageSend builder 
				receiver: RFiAnyMessageReceiver new;
				selector: #+;
				new.
		}

]

{ #category : #tests }
RFiMethodRequisitesTest >> testClassCUndeclared [

	self 
		assertRequisitesOf: resources ringClassC >> #undeclared
		equals: {
			RFiVariableAccess builder
				variableName: #undeclaredVar;
				new.
		}
]
