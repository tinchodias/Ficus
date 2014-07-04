Class {
	#name : #FiNeedIteratorTest,
	#superclass : #TestCase,
	#instVars : [
		'ringShotResource'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiNeedIteratorTest >> assertNeedsOf: aRingMethod equals: aNeed [
	
	self 
		assert: (FiNeedIterator new needsFor: aRingMethod) asSet 
		equals: aNeed asSet
]

{ #category : #running }
FiNeedIteratorTest >> setUp [

	super setUp.
	
	ringShotResource := FiRGShotResource new
]

{ #category : #tests }
FiNeedIteratorTest >> testClassASum [

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
FiNeedIteratorTest >> testClassASum42 [

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
FiNeedIteratorTest >> testClassBSum [

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
FiNeedIteratorTest >> testClassCSum [

	self 
		assertNeedsOf: ringShotResource classC >> #sum
		equals: { }
]
