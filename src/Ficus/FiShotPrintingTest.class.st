Class {
	#name : #FiShotPrintingTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #'as yet unclassified' }
FiShotPrintingTest >> testStoreString [

	| shot otherShot edit source intermediate effect result |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: otherShot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: (self class compiler evaluate: intermediate storeString) equals: intermediate.
	self assert: (self class compiler evaluate: result storeString) equals: result.
	self assert: (self class compiler evaluate: effect storeString) equals: effect.
]
