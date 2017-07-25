Class {
	#name : #RFiMethodTest,
	#superclass : #RFiObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
RFiMethodTest >> testAllLiterals [
		
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
RFiMethodTest >> testAst [

	self deny: ((resources ringClassA methods collect: #ast) anySatisfy: #isNil).

	self assert: ((resources ringClassA classSide >> #initialize) ast allChildren 
		detect: [ :node | node isVariable and: [ node name = 'A' ] ]) isGlobal
	
]

{ #category : #tests }
RFiMethodTest >> testEnvironment [
		
	| environment |
	environment := resources ringEnvironment.
	
	self assert: ((environment classNamed: #A) >> #sum) environment == environment
]

{ #category : #tests }
RFiMethodTest >> testIsFromTrait [ 

	self flag: #todo. "Support traits"
			
	self deny: (resources ringClassA >> #sum42) isFromTrait.

]

{ #category : #tests }
RFiMethodTest >> testIsProvided [

	self flag: #todo. "Test with #explicitRequirement, #requirement, etc."

	self assert: ((resources ringEnvironment classNamed: #True) >> #ifTrue:) isProvided.
	self deny: ((resources ringEnvironment classNamed: #Boolean) >> #ifTrue:) isProvided.

]

{ #category : #tests }
RFiMethodTest >> testIsRequired [

	self deny: ((resources ringEnvironment classNamed: #True) >> #ifTrue:) isRequired.
	self assert: ((resources ringEnvironment classNamed: #Boolean) >> #ifTrue:) isRequired.

]

{ #category : #tests }
RFiMethodTest >> testIsReturnSelf [

	self assert: (resources ringClassC >> #returnSelf) isReturnSelf.
	self deny: (resources ringClassC >> #sum) isReturnSelf.

]

{ #category : #tests }
RFiMethodTest >> testLiterals [
		
	self 
		assert: (resources ringClassC >> #string) literals
		equals: (resources ringClassC >> #string) allLiterals
]

{ #category : #tests }
RFiMethodTest >> testMarkerOrNil [

	self 
		assert: ((resources ringEnvironment classNamed: #Boolean) >> #ifTrue:) markerOrNil
		equals: CompiledMethod subclassResponsibilityMarker. 
		
	self 
		assert: ((resources ringEnvironment classNamed: #True) >> #ifTrue:) markerOrNil
		equals: nil
]

{ #category : #tests }
RFiMethodTest >> testMessages [
		
	self deny: ((resources ringClassA methods collect: #messages) anySatisfy: #isNil)
]

{ #category : #tests }
RFiMethodTest >> testNumArgs [
		
	self assert: (resources ringClassC >> #sum) numArgs equals: 0.
	self assert: (resources ringClassC >> #sumAt:) numArgs equals: 1.
	
]

{ #category : #tests }
RFiMethodTest >> testPackage [
	
	self flag: #todo. "Support methods from traits!"
	
	self assert: (resources ringClassA >> #sum) package name equals: #X.
]

{ #category : #tests }
RFiMethodTest >> testParseTree [

	self deny: ((resources ringClassA methods collect: #parseTree) anySatisfy: #isNil).

]

{ #category : #tests }
RFiMethodTest >> testProtocol [
		
	self flag: #todo. "Missing more cases"
	self assert: (resources ringClassA >> #sum) protocol equals: #'as yet unclassified'.

]

{ #category : #tests }
RFiMethodTest >> testReferredInstVars [

	self flag:#todo. "Test better (it should fail easily)"
	self assert: (resources ringClassA >> #sum) referredInstVars asSet equals: #(a1 a2) asSet.
	self assert: (resources ringClassB >> #defaultClass) referredInstVars isEmpty.
]

{ #category : #tests }
RFiMethodTest >> testRefersToLiteral [
		
	self assert: ((resources ringClassA >> #sum42) refersToLiteral: #sum).
	self assert: ((resources ringClassB >> #defaultClass) refersToLiteral: 
		(resources ringEnvironment associationAt: #C)).
	self assert: ((resources ringClassC >> #sum) refersToLiteral: 0.0).
	self assert: ((resources ringClassC >> #string) refersToLiteral: 'a string').
	self assert: ((resources ringClassC >> #array1) refersToLiteral: #(1 2)).

	"These may look weird, but it works like this in reality."	
	self assert: ((resources ringClassC >> #array1) refersToLiteral: 1).	
	self deny: ((resources ringClassC >> #array1) refersToLiteral: 
		(resources ringEnvironment bindingOf: #B)).

]

{ #category : #tests }
RFiMethodTest >> testSelfMessages [
		
	self assert: (resources ringClassA >> #sum42) selfMessages equals: #(sum) asSet
]

{ #category : #tests }
RFiMethodTest >> testSendsSelector [
		
	self assert: ((resources ringClassA >> #sum) sendsSelector: #+).
	self deny: ((resources ringClassA >> #sum) sendsSelector: #/).	
]

{ #category : #tests }
RFiMethodTest >> testSuperMessages [
		
	self assert: (resources ringClassB >> #sum) superMessages equals: #(sum) asSet
]
