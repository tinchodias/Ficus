Class {
	#name : #FiSetSimpleEffectsTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-SimpleEffects'
}

{ #category : #tests }
FiSetSimpleEffectsTest >> testAddition [

	| shot edit source effect simpleEffects |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	effect := source effectOf: edit.

	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root -> effect }.

	self flag: #todo. "refactor"
	simpleEffects := effect asSimpleEffects.
	self assert: simpleEffects isCollection.
	self assert: simpleEffects size equals: 1.
	self assert: (simpleEffects anyOne isKindOf: FiAddition).
	self assert: simpleEffects anyOne path equals: #(A) asFicusPath.
	self assert: simpleEffects anyOne children isNotEmpty.
	self assert: (simpleEffects anyOne children allSatisfy: [ :each | each isKindOf: FiAddition ]).

	self 
		assert: (source resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (source resultOf: effect edit).
]

{ #category : #tests }
FiSetSimpleEffectsTest >> testNoEffect [

	| shot edit source intermediate effect |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: shot.
	effect := intermediate effectOf: edit.

	self assert: effect flattenedLeafEffects isEmpty.
	
	self 
		assert: (intermediate resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (intermediate resultOf: effect edit).
]

{ #category : #tests }
FiSetSimpleEffectsTest >> testRemoval [

	| edit source shot intermediate effect simpleEffects |
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
	simpleEffects := effect asSimpleEffects.
	self assert: simpleEffects isCollection.
	self assert: simpleEffects size equals: 1.
	self assert: (simpleEffects anyOne isKindOf: FiRemoval).
	self assert: simpleEffects anyOne path equals: #(A) asFicusPath.
	self assert: simpleEffects anyOne children isNotEmpty.
	self assert: (simpleEffects anyOne children allSatisfy: [ :each | each isKindOf: FiRemoval ]).

	self 
		assert: (intermediate resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (intermediate resultOf: effect edit).
]

{ #category : #tests }
FiSetSimpleEffectsTest >> testUpdate [

	| shot otherShot edit source intermediate effect simpleEffects |
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
	simpleEffects := effect asSimpleEffects.
	self assert: simpleEffects isCollection.
	self assert: simpleEffects size equals: 1.
	self assert: (simpleEffects anyOne isKindOf: FiUpdate).
	self assert: simpleEffects anyOne path equals: #(A) asFicusPath.
	self assert: simpleEffects anyOne children isNotEmpty.
	self assert: (simpleEffects anyOne children allSatisfy: [ :each | each isKindOf: FiUpdate ]).

	self 
		assert: (intermediate resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (intermediate resultOf: effect edit).
]
