"
A FiSetTest is a test class for testing the behavior of FiSet
"
Class {
	#name : #FiSetTest,
	#superclass : #TestCase,
	#category : #'Ficus2-Core-Tests-Model'
}

{ #category : #tests }
FiSetTest >> testInstantiation [
	self assert: #() asFiSet equals: #() asFiSet.
	self assert: #(1) asFiSet equals: #(1) asFiSet.
	self assert: #(1) asFiSet equals: #(1) asSet asFiSet
	"self assert: #(1 1) asFiSet equals: #(1) asFiSet."
]

{ #category : #tests }
FiSetTest >> testInstantiationWithStepsAndValues [

	| shot |
	self assert: (FiSet newFromStepsAndValues: Dictionary new) stepCount equals: 0.

	shot := 
		FiSet newFromStepsAndValues: 
			(Dictionary new
				at: #A put: (FiChef nickname: #A);
				at: #B put: (FiChef nickname: #B);
				yourself).

	self assert: shot steps asSet equals: #(A B) asSet.
	self assert: (shot valueAt: #A) equals: (FiChef nickname: #A).
	self assert: (shot valueAt: #B) equals: (FiChef nickname: #B).
]
