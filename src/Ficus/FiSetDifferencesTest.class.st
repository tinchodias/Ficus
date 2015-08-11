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
	
	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: edit).

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
	
	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: edit).
	self assert: (source differenceFrom: result) equals: (result effectOf: (result editInclude: shot)).
]

{ #category : #tests }
FiSetDifferencesTest >> testReplacement [

	| source result |
	result := FiSet new.
	source := 42.

	self 
		assert: (result differenceFrom: source) 
		equals: (source effectOfReplaceBy: result).

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
	
	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: expectedDifference).

]
