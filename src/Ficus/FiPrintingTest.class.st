Class {
	#name : #FiPrintingTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiPrintingTest >> testStoreString [

	| shot otherShot edit source intermediate effect result |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: otherShot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self flag: #todo. "Refactor"

	self assert: (self class compiler evaluate: source storeString) equals: source.
	self assert: (self class compiler evaluate: intermediate storeString) equals: intermediate.
	self assert: (self class compiler evaluate: result storeString) equals: result.
	self assert: (self class compiler evaluate: effect storeString) equals: effect.
	self assert: (self class compiler evaluate: (1 -> effect) storeString) equals: (1 -> effect).
	self assert: (self class compiler evaluate: (1 -> result) storeString) equals: (1 -> result).

]
