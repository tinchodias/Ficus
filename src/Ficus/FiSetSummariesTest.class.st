Class {
	#name : #FiSetSummariesTest,
	#superclass : #TestCase,
	#category : #'Ficus-UI-Tests'
}

{ #category : #tests }
FiSetSummariesTest >> testAddition [

	| shot edit source effect summary |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source include: shot.
	effect := source effectOf: edit.

	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root -> effect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryAdd).
	self assert: summary anyOne path equals: #(A) asFicusPath.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryAdd ]).

]

{ #category : #tests }
FiSetSummariesTest >> testNoEffect [

	| shot edit source intermediate effect |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate include: shot.
	effect := intermediate effectOf: edit.

	self assert: effect flattenedLeafEffects isEmpty.
]

{ #category : #tests }
FiSetSummariesTest >> testRemoval [

	| edit source shot intermediate effect summary |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot.
	effect := intermediate effectOf: edit.

	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root -> effect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryRemove).
	self assert: summary anyOne path equals: #(A) asFicusPath.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryRemove ]).

]

{ #category : #tests }
FiSetSummariesTest >> testUpdate [

	| shot otherShot edit source intermediate effect summary |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot at: #shortBio equal: '42').

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate include: otherShot.
	effect := intermediate effectOf: edit.

	self flag: #todo. "For coherence with other set effects, we should expect: FiPath root / -> a FiUpdateEffect"
	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #A / #shortBio -> effect subEffect subEffect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryUpdate).
	self assert: summary anyOne path equals: #(A) asFicusPath.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryUpdate ]).

]
