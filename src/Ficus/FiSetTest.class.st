"
A FiSetTest is a test class for testing the behavior of FiSet
"
Class {
	#name : #FiSetTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-Edits'
}

{ #category : #tests }
FiSetTest >> testAddition [

	| edit source result shot |
	source := FiSet new.
	shot := FiChef nickname: #A.
	
	edit := source editInclude: shot.
	result := source resultOf: edit.

	self assert: source values isEmpty.
	self assert: result values equals: { shot }.
	self assert: (result valueAt: shot defaultStep) equals: shot.
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
				at: #A put: (FiChef nickname: #A);
				at: #B put: (FiChef nickname: #B);
				yourself).

	self assert: shot steps asSet equals: #(A B) asSet.
	self assert: (shot valueAt: #A) equals: (FiChef nickname: #A).
	self assert: (shot valueAt: #B) equals: (FiChef nickname: #B).
]

{ #category : #tests }
FiSetTest >> testRemoval [

	| edit source result shot intermediate |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot.
	result := intermediate resultOf: edit.
	
	self assert: source values isEmpty.
	self assert: intermediate values equals: { shot }.
	self assert: result values isEmpty.

]

{ #category : #tests }
FiSetTest >> testUpdate [

	| shot otherShot edit source result intermediate |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: otherShot.
	result := intermediate resultOf: edit.
	
	self assert: source values isEmpty.
	self assert: intermediate values equals: { shot }.
	self assert: result values equals: { otherShot }.

]
