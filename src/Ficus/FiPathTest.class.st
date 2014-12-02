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
	#category : #'Ficus-Tests-Path'
}

{ #category : #running }
FiPathTest >> assertStoreStringRoundTripOf: aPath [

	self assert: (self class evaluate: aPath storeString) equals: aPath.
]

{ #category : #running }
FiPathTest >> sampleShot [
	
	| aSet aShot |
	aShot := FiChef nickname: #A.
	
	aSet := FiSet new.
	^ aSet resultOf: (aSet editInclude: aShot)
]

{ #category : #tests }
FiPathTest >> testAsFicusPath [

	| pathA pathB |
	pathA := FiPath root / #A / #admiredChefs / #X.
	pathB := #(A admiredChefs X) asFiPath.
		
	self assert: pathB equals: pathA.

]

{ #category : #tests }
FiPathTest >> testClass [

	shot := self sampleShot.
	path := FiPath root / #A.
		
	self assert: ((path resolvedOn: shot) isKindOf: FiChef).
]

{ #category : #tests }
FiPathTest >> testEquals [

	| pathA pathB |
	pathA := FiPath root / #A / #admiredChefs / #X.
	pathB := FiPath root / #A / #admiredChefs / #X.
		
	self assert: pathA equals: pathB.
	self assert: pathB equals: pathA.
]

{ #category : #tests }
FiPathTest >> testFlattened [

	| aSet aShot |
	aShot := FiRecipe title: 'fortyTwo' kind: #accessing.
	aSet := { aShot } asFiSet.

	self 
		assert: aSet flattened 
		equals: { 
			FiPath root -> aSet.
			FiPath root / #fortyTwo -> aShot.
			FiPath root / #fortyTwo / #title -> 'fortyTwo'.
			FiPath root / #fortyTwo / #kind -> #accessing.
			}.
]

{ #category : #tests }
FiPathTest >> testFromStream [

	| pathA pathB |
	pathA := FiPath root / #A / #admiredChefs / #X.
	pathB := FiPath fromStream: #(A admiredChefs X) readStream.
		
	self assert: pathA equals: pathB.

]

{ #category : #tests }
FiPathTest >> testNotEquals [

	| pathA pathB |
	pathA := FiPath root / #A / #admiredChefs / #X.
	pathB := FiPath root / #A / #admiredChefs / #Y.
	
	self deny: pathA = pathB.
	self deny: pathB = pathA.
]

{ #category : #tests }
FiPathTest >> testSharedPools [

	shot := self sampleShot.
	path := FiPath root / #A / #admiredChefs.
		
	self assert: ((path resolvedOn: shot) isKindOf: FiSet).
]

{ #category : #tests }
FiPathTest >> testSteps [

	path := FiPath root / #A / #admiredChefs / #X.
		
	self assert: path steps equals: #(A admiredChefs X).
]

{ #category : #tests }
FiPathTest >> testStoreString [

	self assertStoreStringRoundTripOf: FiPath root.
	self assertStoreStringRoundTripOf: FiPath root / #A.
	self assertStoreStringRoundTripOf: FiPath root / #A / #B.
	self assertStoreStringRoundTripOf: FiPath root / 1 / 4.2.
]
