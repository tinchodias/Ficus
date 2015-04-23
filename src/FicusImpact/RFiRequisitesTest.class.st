Class {
	#name : #RFiRequisitesTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
RFiRequisitesTest >> assertRequisitesOf: aRFiObject equals: dependencies [
	
	self 
		assert: aRFiObject ficusRequisites asSet 
		equals: dependencies asSet
]

{ #category : #running }
RFiRequisitesTest >> setUp [

	super setUp.
	
	resources := RFiRingTestResources new
]

{ #category : #'tests - class' }
RFiRequisitesTest >> testClassA [

	self 
		assertRequisitesOf: resources ringClassA
		equals: {
			RFiInheritanceDeclaration builder
				theClassName: #Object;
				new
			}
]

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassAClassInitialize [

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

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassASum [

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

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassASum42 [

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

{ #category : #'tests - class' }
RFiRequisitesTest >> testClassB [

	self 
		assertRequisitesOf: resources ringClassB
		equals: {
			RFiInheritanceDeclaration builder
				theClassName: #A;
				new
				}
]

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassBDefaultClass [

	self 
		assertRequisitesOf: resources ringClassB >> #defaultClass
		equals: {
			RFiVariableAccess builder
				variableName: #C;
				new.
			}
]

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassBReadSomeClassVariable [

	self 
		assertRequisitesOf: resources ringClassB >> #readSomeClassVariable
		equals: {
			RFiVariableAccess builder
				variableName: #SomeClassVariable;
				new.
			}
]

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassBSum [

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

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassBVariableInSuper [

	self 
		assertRequisitesOf: resources ringClassB >> #variableInSuper
		equals: {
			RFiVariableAccess builder
				variableName: #a1;
				new.
			}
]

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassCSum [

	self 
		assertRequisitesOf: resources ringClassC >> #sum
		equals: {}
]

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassCSumAt [

	self 
		assertRequisitesOf: resources ringClassC >> #sumAt:
		equals: {
			RFiMessageSend builder 
				receiver: RFiAnyMessageReceiver new;
				selector: #sum;
				new.
		}

]

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassCSumTmp [

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

{ #category : #'tests - method' }
RFiRequisitesTest >> testClassCUndeclared [

	self 
		assertRequisitesOf: resources ringClassC >> #undeclared
		equals: {
			RFiVariableAccess builder
				variableName: #undeclaredVar;
				new.
		}
]

{ #category : #'tests - class' }
RFiRequisitesTest >> testClassObject [

	self 
		assertRequisitesOf: resources ringClassObject
		equals: {
			}
]
