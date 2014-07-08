"
A FiSetTest is a test class for testing the behavior of FiSet
"
Class {
	#name : #FiSetTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiSetTest >> testAddClass [

	| edit source result shot |
	source := FiSet new.
	shot := FiClass named: #A.
	
	edit := source include: shot.
	result := source resultOf: edit.

	self assert: source values isEmpty.
	self assert: result values equals: { shot }.
	self assert: (result shotAt: shot defaultStep) equals: shot.
	self assert: result stepsAndValues equals: { shot defaultStep -> shot } asSet.
]

{ #category : #tests }
FiSetTest >> testInstanciation [

	self assert: (FiSet withValues: #()) equals: (FiSet withValues: #()).

	self assert: (FiSet withValues: #(1)) equals: (FiSet withValues: #(1)).
	self assert: (FiSet withValues: #(1)) equals: (FiSet withValues: #(1) asSet).
	"self assert: (FiSet withValues: #(1 1)) equals: (FiSet withValues: #(1))."

]

{ #category : #tests }
FiSetTest >> testInstanciationWithStepsAndValues [

	| shot |
	self assert: (FiSet newFromStepsAndValues: Dictionary new) stepCount equals: 0.

	shot := 
		FiSet newFromStepsAndValues: 
			(Dictionary new
				at: #A put: (FiClass named: #A);
				at: #B put: (FiClass named: #B);
				yourself).

	self assert: shot steps asSet equals: #(A B) asSet.
	self assert: (shot shotAt: #A) equals: (FiClass named: #A).
	self assert: (shot shotAt: #B) equals: (FiClass named: #B).
]

{ #category : #tests }
FiSetTest >> testRemoveClass [

	| edit source result shot intermediate |
	source := FiSet new.
	shot := FiClass named: #A.

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot.
	result := intermediate resultOf: edit.
	
	self assert: source values isEmpty.
	self assert: intermediate values equals: { shot }.
	self assert: result values isEmpty.

]

{ #category : #tests }
FiSetTest >> testUpdateClass [

	| shot otherShot edit source result intermediate |
	source := FiSet new.
	shot := FiClass named: #A.
	otherShot := shot resultOf: (shot at: #comment equal: '42').

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate include: otherShot.
	result := intermediate resultOf: edit.
	
	self assert: source values isEmpty.
	self assert: intermediate values equals: { shot }.
	self assert: result values equals: { otherShot }.

]
