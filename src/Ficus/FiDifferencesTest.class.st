"
A FiEnvironmentEditsTest is xxxxxxxxx.

"
Class {
	#name : #FiDifferencesTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests'
}

{ #category : #'tests-dictionary' }
FiDifferencesTest >> testAddClass [

	| edit editEffect source result shot |
	source := FiDictionary new.
	shot := FiClass named: #A.
	
	edit := source at: #A equal: shot.
	editEffect := source effectOf: edit.
	result := source resultOf: edit.

	self assert: (source differenceFrom: source) isNoEdit.
	self assert: (result differenceFrom: result) isNoEdit.
	self assert: (result differenceFrom: source) equals: edit.
	self assert: (source differenceFrom: result) equals: editEffect inverse.
]

{ #category : #'tests-shot' }
FiDifferencesTest >> testAddSharedPool [
	"Test difference with a sub edit."

	| edit inverseEdit source result |
	source := FiClass named: #A.

	edit := source 
		at: #sharedPools
		edit: [ :sharedPools | sharedPools include: #X ].
	
	result := source resultOf: edit.

	inverseEdit := result
		at: #sharedPools
		edit: [ :sharedPools | sharedPools exclude: #X ].

	self assert: (result differenceFrom: source) equals: edit.
	self assert: (source differenceFrom: result) equals: inverseEdit.
]

{ #category : #'tests-shot' }
FiDifferencesTest >> testAddSharedPoolAndUpdateComment [

	| edit inverseEdit source result |
	source := FiClass named: #A.

	edit := source edits: {
		source 
			at: #sharedPools
			edit: [ :sharedPools | sharedPools include: #X ].
		source
			at: #comment
			equal: '42'.
		}.
			
	result := source resultOf: edit.

	inverseEdit := result edits: {
		result 
			at: #sharedPools
			edit: [ :sharedPools | sharedPools exclude: #X ].
		result 
			at: #comment
			equal: ''.
		}.

	self assert: (result differenceFrom: source) equals: edit.
	self assert: (source differenceFrom: result) equals: inverseEdit.
]

{ #category : #'tests-dictionary' }
FiDifferencesTest >> testAddSharedPoolInsideDictionary [
	"Test difference with a sub edit inside a dictionary."

	| edit  source result |
	source := 
		FiDictionary newFromStepsAndValues: 
			(Dictionary new 
				at: #A put: (FiClass named: #A);
				yourself).

	edit := 
		source 
			at: #A
			edit: [ :class | 
				class 
					at: #sharedPools
					edit: [ :sharedPools | sharedPools include: #X ] ].		
	
	result := source resultOf: edit.

	self assert: (result differenceFrom: source) equals: edit.

]

{ #category : #'tests-dictionary' }
FiDifferencesTest >> testAddTwoClasses [

	| edit inverseEdit source result |
	source := FiDictionary new.
	
	edit := source edits: {
		source at: #A equal: (FiClass named: #A).
		source at: #B equal: (FiClass named: #B) }.

	result := source resultOf: edit.

	inverseEdit := result edits: {
		result exclude: #A.
		result exclude: #B }.

	self assert: (source differenceFrom: source) isNoEdit.
	self assert: (result differenceFrom: result) isNoEdit.
	self assert: (result differenceFrom: source) equals: edit.
	self assert: (source differenceFrom: result) equals: inverseEdit.
]

{ #category : #'tests-dictionary' }
FiDifferencesTest >> testNoEditClass [

	| shot edit preSource result source |
	preSource := FiDictionary new.
	shot := FiClass named: #A.

	edit := preSource at: #A equal: shot.
	source := preSource resultOf: edit.

	edit := source at: #A equal: shot.
	result := source resultOf: edit.
	
	self assert: (source differenceFrom: source) isNoEdit.
	self assert: (result differenceFrom: result) isNoEdit.
	self assert: (result differenceFrom: source) isNoEdit.
	self assert: (source differenceFrom: result) isNoEdit.
]

{ #category : #'tests-dictionary' }
FiDifferencesTest >> testRemoveClass [

	| edit editEffect preSource source result shot |
	preSource := FiDictionary new.
	shot := FiClass named: #A.

	edit := preSource at: #A equal: shot.
	source := preSource resultOf: edit.

	edit := source exclude: shot theName.
	editEffect := source effectOf: edit.
	result := source resultOf: edit.
	
	self assert: (source differenceFrom: source) isNoEdit.
	self assert: (result differenceFrom: result) isNoEdit.
	self assert: (result differenceFrom: source) equals: edit.
	self assert: (source differenceFrom: result) equals: editEffect inverse.
]

{ #category : #'tests-set' }
FiDifferencesTest >> testSetAddSharedPool [

	|   edit  result source  |
	source := FiSet new.

	edit := source include: #A.
	result := source resultOf: edit.
	
	self assert: (source differenceFrom: source) isNoEdit.
	self assert: (result differenceFrom: result) isNoEdit.
	self assert: (result differenceFrom: source) equals: edit.

]

{ #category : #'tests-set' }
FiDifferencesTest >> testSetUpdateClass [

	| shot otherShot edit preSource result source expectedDifference |
	preSource := FiSet new.
	shot := FiClass named: #A.
	otherShot := shot resultOf: (shot at: #comment equal: '42').

	edit := preSource include: shot.
	source := preSource resultOf: edit.

	edit := source include: otherShot.
	result := source resultOf: edit.
	
	expectedDifference := 
		source 
			at: #A
			edit: [ :class | 
				class at: #comment equal: '42' ].		
	
	self assert: (source differenceFrom: source) isNoEdit.
	self assert: (result differenceFrom: result) isNoEdit.
	self assert: (result differenceFrom: source) equals: expectedDifference.

]

{ #category : #'tests-dictionary' }
FiDifferencesTest >> testUpdateClass [

	| shot otherShot edit preSource result source expectedDifference |
	preSource := FiDictionary new.
	shot := FiClass named: #A.
	otherShot := shot resultOf: (shot at: #comment equal: '42').

	edit := preSource at: #A equal: shot.
	source := preSource resultOf: edit.

	edit := source at: #A equal: otherShot.
	result := source resultOf: edit.
	
	expectedDifference := 
		source 
			at: #A
			edit: [ :class | 
				class at: #comment equal: '42' ].		
	
	self assert: (source differenceFrom: source) isNoEdit.
	self assert: (result differenceFrom: result) isNoEdit.
	self assert: (result differenceFrom: source) equals: expectedDifference.

]
