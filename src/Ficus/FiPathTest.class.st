"
A MdPathTest is xxxxxxxxx.

Instance Variables
	path:		<Object>
	place:		<Object>

path
	- xxxxx

place
	- xxxxx

"
Class {
	#name : #FiPathTest,
	#superclass : #TestCase,
	#instVars : [
		'path',
		'shot'
	],
	#category : #'Ficus-Tests'
}

{ #category : #running }
FiPathTest >> sampleShot [
	
	| aSet aClass |
	aClass := FiClass named: #A.
	
	aSet := FiSet new.
	^ aSet resultOf: (aSet at: #A equal: aClass)
]

{ #category : #tests }
FiPathTest >> testClass [

	shot := self sampleShot.
	path := FiPath root / #A.
		
	self assert: ((path resolvedOn: shot) isKindOf: FiClass).
]

{ #category : #tests }
FiPathTest >> testEquals [

	| pathA pathB |
	pathA := FiPath root / #A / #sharedPools / #X.
	pathB := FiPath root / #A / #sharedPools / #X.
		
	self assert: pathA equals: pathB.
	self assert: pathB equals: pathA.
]

{ #category : #tests }
FiPathTest >> testFlattened [

	| aSet aMethod |
	aMethod := FiMethod selector: #fortyTwo sourceCode: 'fortyTwo ^42' protocol: #accessing.
	aSet := FiSet withValues: { aMethod }.

	self 
		assert: aSet flattened 
		equals: { 
			FiPath root -> aSet.
			FiPath root / #fortyTwo -> aMethod.
			FiPath root / #fortyTwo / #selector -> #fortyTwo.
			FiPath root / #fortyTwo / #sourceCode -> 'fortyTwo ^42'.
			FiPath root / #fortyTwo / #protocol -> #accessing.
			}.
]

{ #category : #tests }
FiPathTest >> testNotEquals [

	| pathA pathB |
	pathA := FiPath root / #A / #sharedPools / #X.
	pathB := FiPath root / #A / #sharedPools / #Y.
	
	self deny: pathA = pathB.
	self deny: pathB = pathA.
]

{ #category : #tests }
FiPathTest >> testSharedPools [

	shot := self sampleShot.
	path := FiPath root / #A / #sharedPools.
		
	self assert: ((path resolvedOn: shot) isKindOf: FiSet).
]

{ #category : #tests }
FiPathTest >> testSteps [

	path := FiPath root / #A / #sharedPools / #X.
		
	self assert: path steps equals: #(A sharedPools X).
]
