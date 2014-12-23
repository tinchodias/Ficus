Class {
	#name : #FiRGMethodTest,
	#superclass : #FiRGObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGMethodTest >> testAllLiterals [
		
	self 
		assert: (resources classC >> #string) allLiterals
		equals: { 
			#string.
			'a string'.
			#C -> resources classC.
			}.

	self 
		assert: (resources classC >> #array1) allLiterals
		equals: {
			#array1.
			#(1 2).
			#C -> resources classC.
			}.

]

{ #category : #tests }
FiRGMethodTest >> testAst [

	self deny: ((resources classA methods collect: #ast) anySatisfy: #isNil).

]

{ #category : #tests }
FiRGMethodTest >> testEnvironment [
		
	| environment |
	environment := resources environmentWithAll.
	
	self assert: ((environment classNamed: #A) >> #sum) environment == environment
]

{ #category : #tests }
FiRGMethodTest >> testIsFromTrait [ 

	self flag: #todo. "Support traits"
			
	self deny: (resources classA >> #sum42) isFromTrait.

]

{ #category : #tests }
FiRGMethodTest >> testMessages [
		
	self deny: ((resources classA methods collect: #messages) anySatisfy: #isNil)
]

{ #category : #tests }
FiRGMethodTest >> testNumArgs [
		
	self assert: (resources classC >> #sum) numArgs equals: 0.
	self assert: (resources classC >> #sumAt:) numArgs equals: 1.
	
]

{ #category : #tests }
FiRGMethodTest >> testPackage [
	
	self flag: #todo. "Support methods from traits!"
	
	self assert: (resources classA >> #sum) package name equals: #X.
]

{ #category : #tests }
FiRGMethodTest >> testParseTree [

	self deny: ((resources classA methods collect: #parseTree) anySatisfy: #isNil).

]

{ #category : #tests }
FiRGMethodTest >> testProtocol [
		
	self flag: #todo. "Missing more cases"
	self assert: (resources classA >> #sum) protocol equals: #'as yet unclassified'.

]

{ #category : #tests }
FiRGMethodTest >> testReferredInstVars [

	self flag:#todo. "Test better (it should fail easily)"
	self assert: (resources classA >> #sum) referredInstVars asSet equals: #(a1 a2) asSet.
	self assert: (resources classB >> #defaultClass) referredInstVars isEmpty.
]

{ #category : #tests }
FiRGMethodTest >> testRefersToLiteral [
		
	self assert: ((resources classA >> #sum42) refersToLiteral: #sum).
	self assert: ((resources classB >> #defaultClass) refersToLiteral: 
		(resources environmentWithAll associationAt: #C)).
	self assert: ((resources classC >> #sum) refersToLiteral: 0.0).
	self assert: ((resources classC >> #string) refersToLiteral: 'a string').
	self assert: ((resources classC >> #array1) refersToLiteral: #(1 2)).

	"These may look weird, but it works like this in reality."	
	self assert: ((resources classC >> #array1) refersToLiteral: 1).	
	self deny: ((resources classC >> #array1) refersToLiteral: 
		(resources environmentWithAll bindingOf: #B)).

]

{ #category : #tests }
FiRGMethodTest >> testSelfMessages [
		
	self assert: (resources classA >> #sum42) selfMessages equals: #(sum) asSet
]

{ #category : #tests }
FiRGMethodTest >> testSendsSelector [
		
	self assert: ((resources classA >> #sum) sendsSelector: #+).
	self deny: ((resources classA >> #sum) sendsSelector: #/).	
]

{ #category : #tests }
FiRGMethodTest >> testSuperMessages [
		
	self assert: (resources classB >> #sum) superMessages equals: #(sum) asSet
]
