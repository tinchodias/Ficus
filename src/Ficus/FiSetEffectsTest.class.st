Class {
	#name : #FiSetEffectsTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-Effects'
}

{ #category : #tests }
FiSetEffectsTest >> testAddition [

	| shot edit source result effect summary |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source include: shot.
	effect := source effectOf: edit.
	result := source resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result exclude: shot).
	
	self assert: source values isEmpty.
	self assert: result values asSet equals: { shot } asSet.
	self assert: (result resultOf: effect inverse) values isEmpty.

	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root -> effect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryAdd).
	self assert: summary anyOne path equals: #A asFicusPath.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryAdd ]).

]

{ #category : #tests }
FiSetEffectsTest >> testNoEffect [

	| shot edit source result intermediate effect reverted |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate include: shot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: effect inverse.

	self assert: effect edit equals: FiNoEdit new.
	self assert: effect inverse equals: FiNoEdit new.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { shot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

	self assert: effect flattenedLeafEffects isEmpty.
]

{ #category : #tests }
FiSetEffectsTest >> testRemoval [

	| edit source result shot intermediate reverted effect summary |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result include: shot).

	reverted := result resultOf: effect inverse.
		
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.
	self assert: reverted values asSet equals: { shot } asSet.

	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root -> effect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryRemove).
	self assert: summary anyOne path equals: #A asFicusPath.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryRemove ]).

]

{ #category : #tests }
FiSetEffectsTest >> testUpdate [

	| shot otherShot edit source result intermediate effect reverted summary |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot at: #shortBio equal: '42').

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate include: otherShot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result include: shot).

	reverted := result resultOf: effect inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

	self flag: #todo. "For coherence with other set effects, we should expect: FiPath root / -> a FiUpdateEffect"
	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #A / #shortBio -> effect subEffect subEffect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryUpdate).
	self assert: summary anyOne path equals: #A asFicusPath.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryUpdate ]).

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
	
	self assert: (source shotAt: #A) shortBio equals: ''.
	self assert: (result shotAt: #A) shortBio equals: '42'.
	self assert: (source effectOf: edit) equals: (result differenceFrom: source).

]
