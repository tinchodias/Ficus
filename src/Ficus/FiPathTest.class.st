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
FiPathTest >> testAsFiPath [

	| pathA pathB |
	pathA := FiPath root / #A / #admiredChefs / #X.
	pathB := #(A admiredChefs X) asFiPath.
		
	self assert: pathB equals: pathA.

]

{ #category : #tests }
FiPathTest >> testBeginsWith [

	| pathA pathB |
	pathA := FiPath root / #A / #admiredChefs / #X.
	pathB := FiPath root / #A / #admiredChefs.
	
	self assert: (pathA beginsWith: pathB).
	self deny: (pathB beginsWith: pathA).
]

{ #category : #tests }
FiPathTest >> testCanBeResolvedOn [

	shot := self sampleShot.

	self assert: (FiPath root / #A canBeResolvedOn: shot).

	self deny: (FiPath root / #B canBeResolvedOn: shot).
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
FiPathTest >> testResolvedOn [

	shot := self sampleShot.
	path := FiPath root / #A / #admiredChefs.

	self 
		assert: (path resolvedOn: shot) 
		equals: shot asArray first admiredChefs.
]

{ #category : #tests }
FiPathTest >> testResolvedOnIfAbsent [

	shot := self sampleShot.

	(FiPath root / #A
		resolvedOn: shot 
		ifAbsent: [ self fail ]).

	self deny: 
		(FiPath root / #B
			resolvedOn: shot 
			ifAbsent: [ false ]).


	path := FiPath root / #A / #absent
		resolvedOn: shot 
		ifAbsent: [ :resolvedSubPath | path := resolvedSubPath ].	
	
	self assert: path equals: FiPath root / #A
]

{ #category : #tests }
FiPathTest >> testResolvedOnIfPresentIfAbsent [

	shot := self sampleShot.

	self assert:
		(FiPath root / #A
			resolvedOn: shot 
			ifPresent: [ true ] 
			ifAbsent: [ false ]).

	self deny: 
		(FiPath root / #B
			resolvedOn: shot 
			ifPresent: [ true ] 
			ifAbsent: [ false ]).


	path := FiPath root / #A / #absent
		resolvedOn: shot 
		ifPresent: [ self fail ] 
		ifAbsent: [ :resolvedSubPath | path := resolvedSubPath ].	
	
	self assert: path equals: FiPath root / #A
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
