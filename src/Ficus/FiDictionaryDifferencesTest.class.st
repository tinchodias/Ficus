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
	
	edit := source at: #A equal: shot.
	result := source resultOf: edit.

	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: edit).
	self assert: (source differenceFrom: result) equals: (result effectOf: (result exclude: #A)).
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
			at: #A
			edit: [ :class | 
				class 
					at: #admiredChefs
					edit: [ :admiredChefs | admiredChefs include: #X ] ].		
	
	result := source resultOf: edit.

	self assert: (result differenceFrom: source) equals: (source effectOf: edit).

]

{ #category : #tests }
FiDictionaryDifferencesTest >> testNoEdit [

	| shot edit preSource result source |
	preSource := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := preSource at: #A equal: shot.
	source := preSource resultOf: edit.

	edit := source at: #A equal: shot.
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

	edit := preSource at: #A equal: shot.
	source := preSource resultOf: edit.

	edit := source exclude: shot nickname.
	result := source resultOf: edit.
	
	self assert: (source differenceFrom: source) isNoEffect.
	self assert: (result differenceFrom: result) isNoEffect.
	self assert: (result differenceFrom: source) equals: (source effectOf: edit).
	self assert: (source differenceFrom: result) equals: (result effectOf: (result at: #A equal: shot)).
]

{ #category : #tests }
FiDictionaryDifferencesTest >> testReplacement [

	| source result |
	result := FiDictionary new.
	source := 42.

	self 
		assert: (result differenceFrom: source) 
		equals: (result effectOfReplace: source).

]

{ #category : #tests }
FiDictionaryDifferencesTest >> testTwoAdditions [

	| edit inverseEdit source result |
	source := FiDictionary new.
	
	edit := source edits: {
		source at: #A equal: (FiChef nickname: #A).
		source at: #B equal: (FiChef nickname: #B) }.

	result := source resultOf: edit.

	inverseEdit := result edits: {
		result exclude: #A.
		result exclude: #B }.

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
	otherShot := shot resultOf: (shot at: #shortBio equal: '42').

	edit := preSource at: #A equal: shot.
	source := preSource resultOf: edit.

	edit := source at: #A equal: otherShot.
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
