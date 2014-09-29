Class {
	#name : #FiDictionarySummariesTest,
	#superclass : #TestCase,
	#category : #'Ficus-UI-Tests'
}

{ #category : #tests }
FiDictionarySummariesTest >> testAddition [

	| shot edit source effect summary |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source at: #A equal: shot.
	effect := source effectOf: edit.

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
FiDictionarySummariesTest >> testNoEffect [

	| shot edit source intermediate effect |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: shot.
	effect := intermediate effectOf: edit.

	self assert: effect flattenedLeafEffects isEmpty.
	self assert: effect hierarchicalSummary isEmpty.
]

{ #category : #tests }
FiDictionarySummariesTest >> testRemoval [

	| edit source shot intermediate effect summary |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot nickname.
	effect := intermediate effectOf: edit.

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
FiDictionarySummariesTest >> testUpdate [

	| shot otherShot edit source intermediate effect |
	source := FiDictionary new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot at: #shortBio equal: '42').

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: otherShot.
	effect := intermediate effectOf: edit.

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
