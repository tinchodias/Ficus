Class {
	#name : #FiSetDifferencesTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-Differences'
}

{ #category : #tests }
FiSetDifferencesTest >> testAddition [

	|   edit  result source  |
	source := FiSet new.

	edit := source include: #A.
	result := source resultOf: edit.
	
	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: edit).

]

{ #category : #tests }
FiSetDifferencesTest >> testRemoval [

	| edit preSource source result shot |
	preSource := FiSet new.
	shot := FiChef nickname: #A.

	edit := preSource include: shot.
	source := preSource resultOf: edit.

	edit := source exclude: shot.
	result := source resultOf: edit.
	
	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: edit).
	self assert: (source differenceFrom: result) equals: (result effectOf: (result include: shot)).
]

{ #category : #tests }
FiSetDifferencesTest >> testReplacement [

	| source result |
	result := FiSet new.
	source := 42.

	self 
		assert: (result differenceFrom: source) 
		equals: (result effectOfReplace: source).

]

{ #category : #tests }
FiSetDifferencesTest >> testUpdate [

	| shot otherShot edit preSource result source expectedDifference |
	preSource := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot at: #shortBio equal: '42').

	edit := preSource include: shot.
	source := preSource resultOf: edit.

	edit := source include: otherShot.
	result := source resultOf: edit.
	
	expectedDifference := 
		source 
			at: #A
			edit: [ :class | 
				class at: #shortBio equal: '42' ].		
	
	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: expectedDifference).

]
