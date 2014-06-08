Class {
	#name : #FiDictionaryTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiDictionaryTest >> testAddClass [

	| edit source result shot |
	source := FiDictionary new.
	shot := FiClass named: #A.
	
	edit := source at: #A equal: shot.
	result := source resultOf: edit.

	self assert: source valueByKey isEmpty.
	self assert: result valueByKey asSet equals: { shot } asSet.
]

{ #category : #tests }
FiDictionaryTest >> testRemoveClass [

	| edit source result shot intermediate |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot theName.
	result := intermediate resultOf: edit.
	
	self assert: source valueByKey isEmpty.
	self assert: intermediate valueByKey asSet equals: { shot } asSet.
	self assert: result valueByKey isEmpty.

]

{ #category : #tests }
FiDictionaryTest >> testUpdateClass [

	| shot otherShot edit source result intermediate |
	source := FiDictionary new.
	shot := FiClass named: #A.
	otherShot := shot copy
		comment: 'hi';
		yourself.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: otherShot.
	result := intermediate resultOf: edit.
	
	self assert: source valueByKey isEmpty.
	self assert: intermediate valueByKey asSet equals: { shot } asSet.
	self assert: result valueByKey asSet equals: { otherShot } asSet.

]
