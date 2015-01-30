Class {
	#name : #FiRGMethodTest,
	#superclass : #FiRGObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGMethodTest >> testAllLiterals [
		
	self 
		assert: (resources ringClassC >> #string) allLiterals
		equals: { 
			#string.
			'a string'.
			#C -> resources ringClassC.
			}.

	self 
		assert: (resources ringClassC >> #array1) allLiterals
		equals: {
			#array1.
			#(1 2).
			#C -> resources ringClassC.
			}.

]

{ #category : #tests }
FiRGMethodTest >> testAst [

	self deny: ((resources ringClassA methods collect: #ast) anySatisfy: #isNil).

	self assert: ((resources ringClassA classSide >> #initialize) ast allChildren 
		detect: [ :node | node isVariable and: [ node name = 'A' ] ]) isGlobal
	
]

{ #category : #tests }
FiRGMethodTest >> testEnvironment [
		
	| environment |
	environment := resources ficusRGEnvironment.
	
	self assert: ((environment classNamed: #A) >> #sum) environment == environment
]

{ #category : #tests }
FiRGMethodTest >> testIsFromTrait [ 

	self flag: #todo. "Support traits"
			
	self deny: (resources ringClassA >> #sum42) isFromTrait.

]

{ #category : #tests }
FiRGMethodTest >> testIsProvided [

	self flag: #todo. "Test with #explicitRequirement, #requirement, etc."

	self assert: ((resources ficusRGEnvironment classNamed: #True) >> #ifTrue:) isProvided.
	self deny: ((resources ficusRGEnvironment classNamed: #Boolean) >> #ifTrue:) isProvided.

]

{ #category : #tests }
FiRGMethodTest >> testIsRequired [

	self deny: ((resources ficusRGEnvironment classNamed: #True) >> #ifTrue:) isRequired.
	self assert: ((resources ficusRGEnvironment classNamed: #Boolean) >> #ifTrue:) isRequired.

]

{ #category : #tests }
FiRGMethodTest >> testIsReturnSelf [

	self assert: (resources ringClassC >> #returnSelf) isReturnSelf.
	self deny: (resources ringClassC >> #sum) isReturnSelf.

]

{ #category : #tests }
FiRGMethodTest >> testLiterals [
		
	self 
		assert: (resources ringClassC >> #string) literals
		equals: (resources ringClassC >> #string) allLiterals
]

{ #category : #tests }
FiRGMethodTest >> testMarkerOrNil [

	self 
		assert: ((resources ficusRGEnvironment classNamed: #Boolean) >> #ifTrue:) markerOrNil
		equals: CompiledMethod subclassResponsibilityMarker. 
		
	self 
		assert: ((resources ficusRGEnvironment classNamed: #True) >> #ifTrue:) markerOrNil
		equals: nil
]

{ #category : #tests }
FiRGMethodTest >> testMessages [
		
	self deny: ((resources ringClassA methods collect: #messages) anySatisfy: #isNil)
]

{ #category : #tests }
FiRGMethodTest >> testNumArgs [
		
	self assert: (resources ringClassC >> #sum) numArgs equals: 0.
	self assert: (resources ringClassC >> #sumAt:) numArgs equals: 1.
	
]

{ #category : #tests }
FiRGMethodTest >> testPackage [
	
	self flag: #todo. "Support methods from traits!"
	
	self assert: (resources ringClassA >> #sum) package name equals: #X.
]

{ #category : #tests }
FiRGMethodTest >> testParseTree [

	self deny: ((resources ringClassA methods collect: #parseTree) anySatisfy: #isNil).

]

{ #category : #tests }
FiRGMethodTest >> testProtocol [
		
	self flag: #todo. "Missing more cases"
	self assert: (resources ringClassA >> #sum) protocol equals: #'as yet unclassified'.

]

{ #category : #tests }
FiRGMethodTest >> testReferredInstVars [

	self flag:#todo. "Test better (it should fail easily)"
	self assert: (resources ringClassA >> #sum) referredInstVars asSet equals: #(a1 a2) asSet.
	self assert: (resources ringClassB >> #defaultClass) referredInstVars isEmpty.
]

{ #category : #tests }
FiRGMethodTest >> testRefersToLiteral [
		
	self assert: ((resources ringClassA >> #sum42) refersToLiteral: #sum).
	self assert: ((resources ringClassB >> #defaultClass) refersToLiteral: 
		(resources ficusRGEnvironment associationAt: #C)).
	self assert: ((resources ringClassC >> #sum) refersToLiteral: 0.0).
	self assert: ((resources ringClassC >> #string) refersToLiteral: 'a string').
	self assert: ((resources ringClassC >> #array1) refersToLiteral: #(1 2)).

	"These may look weird, but it works like this in reality."	
	self assert: ((resources ringClassC >> #array1) refersToLiteral: 1).	
	self deny: ((resources ringClassC >> #array1) refersToLiteral: 
		(resources ficusRGEnvironment bindingOf: #B)).

]

{ #category : #tests }
FiRGMethodTest >> testSelfMessages [
		
	self assert: (resources ringClassA >> #sum42) selfMessages equals: #(sum) asSet
]

{ #category : #tests }
FiRGMethodTest >> testSendsSelector [
		
	self assert: ((resources ringClassA >> #sum) sendsSelector: #+).
	self deny: ((resources ringClassA >> #sum) sendsSelector: #/).	
]

{ #category : #tests }
FiRGMethodTest >> testSuperMessages [
		
	self assert: (resources ringClassB >> #sum) superMessages equals: #(sum) asSet
]
