Class {
	#name : #FiDictionaryChangesTest,
	#superclass : #TestCase,
	#category : #'FicusExtras-Tests-Core'
}

{ #category : #tests }
FiDictionaryChangesTest >> testAddition [

	| shot edit source result change |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	change := source changeOf: edit.
	result := source resultOf: edit.

	self assert: change edit equals: edit.
	self assert: change inverse equals: (source editExclude: #A).
	
	self assert: source values isEmpty.
	self assert: result values asSet equals: { shot } asSet.
	self assert: (result resultOf: change inverse) values isEmpty.
]

{ #category : #tests }
FiDictionaryChangesTest >> testNoChange [

	| shot edit source result intermediate change |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editAt: #A equal: shot.
	change := intermediate changeOf: edit.
	result := intermediate resultOf: edit.

	self assert: change edit equals: FiNoEdit new.
	self assert: change inverse equals: FiNoEdit new.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { shot } asSet.
]

{ #category : #tests }
FiDictionaryChangesTest >> testRemoval [

	| edit source result shot intermediate reverted change |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot nickname.
	change := intermediate changeOf: edit.
	result := intermediate resultOf: edit.

	self assert: change edit equals: edit.
	self assert: change inverse equals: (result editAt: #A equal: shot).

	reverted := result resultOf: change inverse.
		
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.
	self assert: reverted values asSet equals: { shot } asSet.
]

{ #category : #tests }
FiDictionaryChangesTest >> testUpdate [

	| shot otherShot edit source result intermediate change reverted |
	source := FiDictionary new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editAt: #A equal: otherShot.
	change := intermediate changeOf: edit.
	result := intermediate resultOf: edit.

	self assert: change edit equals: edit.
	self assert: change inverse equals: (result editAt: #A equal: shot).

	reverted := result resultOf: change inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.
]
