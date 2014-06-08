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
	self assert: result values equals: { shot } asSet.
	self assert: (result shotAt: shot defaultStep) equals: shot.
	self assert: result stepsAndValues equals: { shot defaultStep -> shot } asSet.
]

{ #category : #tests }
FiSetTest >> testInstanciation [

	self assert: (FiSet withValues: #(1)) equals: (FiSet withValues: #(1) asSet).
	self assert: (FiSet withValues: #(1 1)) equals: (FiSet withValues: #(1)).

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
	self assert: intermediate values equals: { shot } asSet.
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
	self assert: intermediate values equals: { shot } asSet.
	self assert: result values equals: { otherShot } asSet.

]
