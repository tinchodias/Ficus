Class {
	#name : #FiRGMethodTest,
	#superclass : #FiRGShotTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGMethodTest >> testMessages [
		
	self deny: ((ringShotResource classA methods collect: #messages) anySatisfy: #isNil)
]

{ #category : #tests }
FiRGMethodTest >> testParseTree [

	self deny: ((ringShotResource classA methods collect: #parseTree) anySatisfy: #isNil).

]
