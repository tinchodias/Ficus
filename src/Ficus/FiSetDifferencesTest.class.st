Class {
	#name : #FiSetDifferencesTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiSetDifferencesTest >> testAddition [

	|   edit  result source  |
	source := FiSet new.

	edit := source editInclude: #A.
	result := source resultOf: edit.
	
	self assert: (source changeFrom: source) isNoChange.
	self assert: (result changeFrom: result) isNoChange.
	self assert: (result changeFrom: source) equals: (source changeOf: edit).

]

{ #category : #tests }
FiSetDifferencesTest >> testRemoval [

	| edit preSource source result shot |
	preSource := FiSet new.
	shot := FiChef nickname: #A.

	edit := preSource editInclude: shot.
	source := preSource resultOf: edit.

	edit := source editExclude: shot.
	result := source resultOf: edit.
	
	self assert: (source changeFrom: source) isNoChange.
	self assert: (result changeFrom: result) isNoChange.
	self assert: (result changeFrom: source) equals: (source changeOf: edit).
	self assert: (source changeFrom: result) equals: (result changeOf: (result editInclude: shot)).
]

{ #category : #tests }
FiSetDifferencesTest >> testReplacement [

	| source result |
	result := FiSet new.
	source := 42.

	self 
		assert: (result changeFrom: source) 
		equals: (source changeOfReplaceBy: result).

]

{ #category : #tests }
FiSetDifferencesTest >> testUpdate [

	| shot otherShot edit preSource result source expectedDifference |
	preSource := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := preSource editInclude: shot.
	source := preSource resultOf: edit.

	edit := source editInclude: otherShot.
	result := source resultOf: edit.
	
	expectedDifference := 
		source 
			editAt: #A
			do: [ :class | 
				class editAt: #shortBio equal: '42' ].		
	
	self assert: (source changeFrom: source) isNoChange.
	self assert: (result changeFrom: result) isNoChange.
	self assert: (result changeFrom: source) equals: (source changeOf: expectedDifference).

]
