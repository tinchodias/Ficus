Class {
	#name : #FiSetChangesTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiSetChangesTest >> testAddition [

	| shot edit source result change |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	change := source changeOf: edit.
	result := source resultOf: edit.

	self assert: change edit equals: edit.
	self assert: change inverse equals: (result editExclude: shot).
	
	self assert: source values isEmpty.
	self assert: result values asSet equals: { shot } asSet.
	self assert: (result resultOf: change inverse) values isEmpty.
]

{ #category : #tests }
FiSetChangesTest >> testNoChange [

	| shot edit source result intermediate change reverted |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: shot.
	change := intermediate changeOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: change inverse.

	self assert: change edit equals: FiNoEdit new.
	self assert: change inverse equals: FiNoEdit new.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { shot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.
]

{ #category : #tests }
FiSetChangesTest >> testRemoval [

	| edit source result shot intermediate reverted change |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot.
	change := intermediate changeOf: edit.
	result := intermediate resultOf: edit.

	self assert: change edit equals: edit.
	self assert: change inverse equals: (result editInclude: shot).

	reverted := result resultOf: change inverse.
		
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.
	self assert: reverted values asSet equals: { shot } asSet.
]

{ #category : #tests }
FiSetChangesTest >> testUpdate [

	| shot otherShot edit source result intermediate change reverted |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: otherShot.
	change := intermediate changeOf: edit.
	result := intermediate resultOf: edit.

	self assert: change edit equals: edit.
	self assert: change inverse equals: (result editInclude: shot).

	reverted := result resultOf: change inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.
]

{ #category : #tests }
FiSetChangesTest >> testUpdateWithSubEdit [

	| edit source result |
	source := { FiChef nickname: #A } asFiSet.

	edit := 
		FiSubEdit
			path: FiPath root / #A / #shortBio
			equal: '42'.

	result := source resultOf: edit.
	
	self assert: (source valueAt: #A) shortBio equals: ''.
	self assert: (result valueAt: #A) shortBio equals: '42'.
	self assert: (source changeOf: edit) equals: (result changeFrom: source).

]
