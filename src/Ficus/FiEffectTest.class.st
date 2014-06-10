"
A FiEnvironmentEditsTest is xxxxxxxxx.

"
Class {
	#name : #FiEffectTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests'
}

{ #category : #'tests-dictionary' }
FiEffectTest >> testAddClass [

	| shot edit source reverted result editEffect |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	editEffect := source effectOf: edit.
	result := source resultOf: edit.

	reverted := result resultOf: editEffect inverse.
	
	self assert: source values isEmpty.
	self assert: result values asSet equals: { shot } asSet.
	self assert: reverted values isEmpty.

]

{ #category : #'tests-dictionary' }
FiEffectTest >> testNoEditClass [

	| shot edit source result intermediate editEffect reverted |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: shot.
	editEffect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: editEffect inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { shot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

]

{ #category : #'tests-dictionary' }
FiEffectTest >> testRemoveClass [

	| edit source result shot intermediate reverted editEffect |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot theName.
	editEffect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: editEffect inverse.
		
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.
	self assert: reverted values asSet equals: { shot } asSet.

]

{ #category : #'tests-dictionary' }
FiEffectTest >> testUpdateClass [

	| shot otherShot edit source result intermediate editEffect reverted |
	source := FiDictionary new.
	shot := FiClass named: #A.
	otherShot := shot resultOf: (shot at: #comment equal: '42').

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: otherShot.
	editEffect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: editEffect inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

]

{ #category : #'tests-shot' }
FiEffectTest >> testUpdateComment [

	| edit effect source |
	source := FiClass named: #A.

	edit :=  source at: #comment equal: '42'.
	effect := source effectOf: edit.
	
	self assert: effect oldValue equals: ''.
	self assert: effect edit equals: edit.
]
