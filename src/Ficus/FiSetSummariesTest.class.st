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

	edit := source editInclude: shot.
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

	self 
		assert: (source resultOfHierarchicalSummary: effect hierarchicalSummary) 
		equals: (source resultOf: effect edit).
]

{ #category : #tests }
FiSetSummariesTest >> testNoEffect [

	| shot edit source intermediate effect |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: shot.
	effect := intermediate effectOf: edit.

	self assert: effect flattenedLeafEffects isEmpty.
	
	self 
		assert: (intermediate resultOfHierarchicalSummary: effect hierarchicalSummary) 
		equals: (intermediate resultOf: effect edit).
]

{ #category : #tests }
FiSetSummariesTest >> testRemoval [

	| edit source shot intermediate effect summary |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot.
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

	self 
		assert: (intermediate resultOfHierarchicalSummary: effect hierarchicalSummary) 
		equals: (intermediate resultOf: effect edit).
]

{ #category : #tests }
FiSetSummariesTest >> testUpdate [

	| shot otherShot edit source intermediate effect summary |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: otherShot.
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

	self 
		assert: (intermediate resultOfHierarchicalSummary: effect hierarchicalSummary) 
		equals: (intermediate resultOf: effect edit).
]
