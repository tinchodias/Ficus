"
A FiEnvironmentEditsTest is xxxxxxxxx.

"
Class {
	#name : #FiDictionaryDifferencesTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-Differences'
}

{ #category : #tests }
FiDictionaryDifferencesTest >> testAddition [

	| edit source result shot |
	source := FiDictionary new.
	shot := FiChef nickname: #A.
	
	edit := source editAt: #A equal: shot.
	result := source resultOf: edit.

	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: edit).
	self assert: (source differenceFrom: result) equals: (result effectOf: (result editExclude: #A)).
]

{ #category : #tests }
FiDictionaryDifferencesTest >> testAdditionAndUpdate [
	"Test difference with a sub edit inside a dictionary."

	| edit  source result |
	source := 
		FiDictionary newFromStepsAndValues: 
			(Dictionary new 
				at: #A put: (FiChef nickname: #A);
				yourself).

	edit := 
		source 
			editAt: #A
			do: [ :class | 
				class 
					editAt: #admiredChefs
					do: [ :admiredChefs | admiredChefs editInclude: #X ] ].		
	
	result := source resultOf: edit.

	self assert: (result differenceFrom: source) equals: (source effectOf: edit).

]

{ #category : #tests }
FiDictionaryDifferencesTest >> testNoEdit [

	| shot edit preSource result source |
	preSource := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := preSource editAt: #A equal: shot.
	source := preSource resultOf: edit.

	edit := source editAt: #A equal: shot.
	result := source resultOf: edit.
	
	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) isNoEffect.
	self assert: (source differenceFrom: result) isNoEffect.
]

{ #category : #tests }
FiDictionaryDifferencesTest >> testRemoval [

	| edit preSource source result shot |
	preSource := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := preSource editAt: #A equal: shot.
	source := preSource resultOf: edit.

	edit := source editExclude: shot nickname.
	result := source resultOf: edit.
	
	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: edit).
	self assert: (source differenceFrom: result) equals: (result effectOf: (result editAt: #A equal: shot)).
]

{ #category : #tests }
FiDictionaryDifferencesTest >> testReplacement [

	| source result |
	result := FiDictionary new.
	source := 42.

	self 
		assert: (result differenceFrom: source) 
		equals: (source effectOfReplaceBy: result).

]

{ #category : #tests }
FiDictionaryDifferencesTest >> testTwoAdditions [

	| edit inverseEdit source result |
	source := FiDictionary new.
	
	edit := source editAll: {
		source editAt: #A equal: (FiChef nickname: #A).
		source editAt: #B equal: (FiChef nickname: #B) }.

	result := source resultOf: edit.

	inverseEdit := result editAll: {
		result editExclude: #A.
		result editExclude: #B }.

	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: edit).
	self assert: (source differenceFrom: result) equals: (result effectOf: inverseEdit).
]

{ #category : #tests }
FiDictionaryDifferencesTest >> testUpdate [

	| shot otherShot edit preSource result source expectedDifference |
	preSource := FiDictionary new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := preSource editAt: #A equal: shot.
	source := preSource resultOf: edit.

	edit := source editAt: #A equal: otherShot.
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
