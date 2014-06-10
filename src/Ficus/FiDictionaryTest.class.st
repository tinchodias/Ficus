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
FiDictionaryTest >> testInstanciationWithStepsAndValues [

	| shot |
	self assert: (FiDictionary newFromStepsAndValues: Dictionary new) stepCount equals: 0.

	shot := 
		FiSet newFromStepsAndValues: 
			(Dictionary new
				at: #A put: (FiClass named: #A);
				at: #B put: (FiClass named: #B);
				yourself).

	self assert: shot steps asSet equals: #(A B) asSet.
	self assert: (shot shotAt: #A) equals: (FiClass named: #A).
	self assert: (shot shotAt: #B) equals: (FiClass named: #B).
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
