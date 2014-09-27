Class {
	#name : #FiDictionaryEffectsTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-Effects'
}

{ #category : #tests }
FiDictionaryEffectsTest >> testAddition [

	| shot edit source result effect summary |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source at: #A equal: shot.
	effect := source effectOf: edit.
	result := source resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (source exclude: #A).
	
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
FiDictionaryEffectsTest >> testNoEffect [

	| shot edit source result intermediate effect |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: shot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: FiNoEdit new.
	self assert: effect inverse equals: FiNoEdit new.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { shot } asSet.

	self assert: effect flattenedLeafEffects isEmpty.
	self assert: effect hierarchicalSummary isEmpty.
]

{ #category : #tests }
FiDictionaryEffectsTest >> testRemoval [

	| edit source result shot intermediate reverted effect summary |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot nickname.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result at: #A equal: shot).

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
FiDictionaryEffectsTest >> testUpdate [

	| shot otherShot edit source result intermediate effect reverted |
	source := FiDictionary new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot at: #shortBio equal: '42').

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: otherShot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result at: #A equal: shot).

	reverted := result resultOf: effect inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

	self flag: #todo. "For coherence with other dictionary effects, we should expect: FiPath root / -> a FiUpdateEffect"
	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #A -> effect subEffect }.

	self 
		assert: effect hierarchicalSummary asArray
		equals: 
			{ FiSummaryUpdate builder 
				path: #A asFicusPath;
				oldValue: shot; 
				newValue: otherShot; 
				subSummary: #();
				new }
]
