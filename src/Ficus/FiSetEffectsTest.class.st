Class {
	#name : #FiSetEffectsTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-Effects'
}

{ #category : #tests }
FiSetEffectsTest >> testAddition [

	| shot edit source result effect |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	effect := source effectOf: edit.
	result := source resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result editExclude: shot).
	
	self assert: source values isEmpty.
	self assert: result values asSet equals: { shot } asSet.
	self assert: (result resultOf: effect inverse) values isEmpty.
]

{ #category : #tests }
FiSetEffectsTest >> testNoEffect [

	| shot edit source result intermediate effect reverted |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: shot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: effect inverse.

	self assert: effect edit equals: FiNoEdit new.
	self assert: effect inverse equals: FiNoEdit new.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { shot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.
]

{ #category : #tests }
FiSetEffectsTest >> testRemoval [

	| edit source result shot intermediate reverted effect |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result editInclude: shot).

	reverted := result resultOf: effect inverse.
		
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.
	self assert: reverted values asSet equals: { shot } asSet.
]

{ #category : #tests }
FiSetEffectsTest >> testUpdate [

	| shot otherShot edit source result intermediate effect reverted |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: otherShot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result editInclude: shot).

	reverted := result resultOf: effect inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.
]

{ #category : #tests }
FiSetEffectsTest >> testUpdateWithSubEdit [

	| edit source result |
	source := FiSet withValues: { FiChef nickname: #A }.

	edit := 
		FiSubEdit
			path: FiPath root / #A / #shortBio
			equal: '42'.

	result := source resultOf: edit.
	
	self assert: (source valueAt: #A) shortBio equals: ''.
	self assert: (result valueAt: #A) shortBio equals: '42'.
	self assert: (source effectOf: edit) equals: (result differenceFrom: source).

]
