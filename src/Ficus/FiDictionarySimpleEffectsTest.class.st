Class {
	#name : #FiDictionarySimpleEffectsTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-SimpleEffects'
}

{ #category : #tests }
FiDictionarySimpleEffectsTest >> testAddition [

	| shot edit source effect simpleEffects |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
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
FiDictionarySimpleEffectsTest >> testNoEffect [

	| shot edit source intermediate effect |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editAt: #A equal: shot.
	effect := intermediate effectOf: edit.

	self assert: effect flattenedLeafEffects isEmpty.
	self assert: effect asSimpleEffects isEmpty.
	
	self 
		assert: (intermediate resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (intermediate resultOf: effect edit).
]

{ #category : #tests }
FiDictionarySimpleEffectsTest >> testRemoval [

	| edit source shot intermediate effect simpleEffects |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot nickname.
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
FiDictionarySimpleEffectsTest >> testUpdate [

	| shot otherShot edit source intermediate effect |
	source := FiDictionary new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editAt: #A equal: otherShot.
	effect := intermediate effectOf: edit.

	self flag: #todo. "For coherence with other dictionary effects, we should expect: FiPath root / -> a FiUpdateEffect"
	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #A -> effect subEffect }.

	self 
		assert: effect asSimpleEffects asArray
		equals: 
			{ FiUpdate builder 
				path: #(A) asFicusPath;
				oldValue: shot; 
				newValue: otherShot; 
				children: #();
				new }.
				
	self 
		assert: (intermediate resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (intermediate resultOf: effect edit).
]
