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
				variableName: #SomeSharedPoolVariable;
				new.
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
				new.
			FiMethodOwnerDeclaration named: #A isMeta: true.
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
				new.
			FiMethodOwnerDeclaration named: #A.
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
			FiMethodOwnerDeclaration named: #A.
			}
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassBDefaultClass [

	self 
		assertRequisitesOf: resources ringClassB >> #defaultClass
		equals: {
			FiVariableAccess builder
				variableName: #C;
				new.
			FiMethodOwnerDeclaration named: #B.
			}
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassBReadSomeClassVariable [

	self 
		assertRequisitesOf: resources ringClassB >> #readSomeClassVariable
		equals: {
			FiVariableAccess builder
				variableName: #SomeClassVariable;
				new.
			FiMethodOwnerDeclaration named: #B.
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
				new.
			FiMethodOwnerDeclaration named: #B.
			}
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassBVariableInSuper [

	self 
		assertRequisitesOf: resources ringClassB >> #variableInSuper
		equals: {
			FiVariableAccess builder
				variableName: #a1;
				new.
			FiMethodOwnerDeclaration named: #B.
			}
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassCSum [

	self 
		assertRequisitesOf: resources ringClassC >> #sum
		equals: {
			FiMethodOwnerDeclaration named: #C.
		}
]

{ #category : #tests }
FiMethodRequisitesTest >> testClassCSumAt [

	self 
		assertRequisitesOf: resources ringClassC >> #sumAt:
		equals: {
			FiMessageSend builder 
				receiver: FiAnyMessageReceiver new;
				selector: #sum;
				new.
			FiMethodOwnerDeclaration named: #C.
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
			FiMethodOwnerDeclaration named: #C.
		}

]

{ #category : #tests }
FiMethodRequisitesTest >> testClassCUndeclared [

	self 
		assertRequisitesOf: resources ringClassC >> #undeclared
		equals: {
			FiVariableAccess builder
				variableName: #undeclaredVar;
				new.
			FiMethodOwnerDeclaration named: #C.
		}
]
