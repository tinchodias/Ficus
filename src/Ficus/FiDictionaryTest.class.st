Class {
	#name : #FiDictionaryTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-Edits'
}

{ #category : #tests }
FiDictionaryTest >> testAddition [

	| edit source result shot |
	source := FiDictionary new.
	shot := FiChef nickname: #A.
	
	edit := source editAt: #A equal: shot.
	result := source resultOf: edit.

	self assert: source values isEmpty.
	self assert: result values asSet equals: { shot } asSet.
]

{ #category : #tests }
FiDictionaryTest >> testInstanciationWithStepsAndValues [

	| shot |
	self assert: (FiDictionary newFromStepsAndValues: Dictionary new) stepCount equals: 0.

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
FiDictionaryTest >> testRemoval [

	| edit source result shot intermediate |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot nickname.
	result := intermediate resultOf: edit.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.

]

{ #category : #tests }
FiDictionaryTest >> testUpdate [

	| shot otherShot edit source result intermediate |
	source := FiDictionary new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editAt: #A equal: otherShot.
	result := intermediate resultOf: edit.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.

]
