Class {
	#name : 'FiSetEditsTest',
	#superclass : 'TestCase',
	#category : 'Ficus2-Updates-Tests',
	#package : 'Ficus2-Updates-Tests'
}

{ #category : 'tests' }
FiSetEditsTest >> testAddition [

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

{ #category : 'tests' }
FiSetEditsTest >> testRemoval [

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

{ #category : 'tests' }
FiSetEditsTest >> testUpdate [

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
