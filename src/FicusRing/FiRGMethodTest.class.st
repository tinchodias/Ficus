Class {
	#name : #FiRGMethodTest,
	#superclass : #FiRGShotTest,
	#category : #FicusRing
}

{ #category : #tests }
FiRGMethodTest >> testMessages [
		
	self deny: ((pshotResource classA methods collect: #messages) anySatisfy: #isNil)
]

{ #category : #tests }
FiRGMethodTest >> testParseTree [

	self deny: ((pshotResource classA methods collect: #parseTree) anySatisfy: #isNil).

]
