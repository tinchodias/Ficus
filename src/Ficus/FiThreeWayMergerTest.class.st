Class {
	#name : #FiThreeWayMergerTest,
	#superclass : #TestCase,
	#instVars : [
		'a1',
		'b1',
		'c1',
		'a2',
		'd1'
	],
	#category : #'Ficus-Model-Merge'
}

{ #category : #running }
FiThreeWayMergerTest >> assertMergeBase: baseShot withTarget: targetShot andAncestor: ancestor equals: expectedResult conflicts: expectedConflicts [

	| merger |
	merger := 
		FiThreeWayMerger
			base: baseShot
			target: targetShot
			ancestor: ancestor.

	self assert: merger result equals: expectedResult.
	self assert: merger conflicts equals: expectedConflicts.
]

{ #category : #tests }
FiThreeWayMergerTest >> test01AdditiveConflictlessMerge [

	a1 := FiChef nickname: #A.
	b1 := FiChef nickname: #B.
	c1 := FiChef nickname: #C.

	self
		assertMergeBase: {a1. b1} asFiSet
		withTarget: {a1. c1} asFiSet
		andAncestor: {a1} asFiSet
		equals: {a1. b1. c1} asFiSet
		conflicts: #()
]

{ #category : #tests }
FiThreeWayMergerTest >> test02SimultaneousRemove [

	a1 := FiChef nickname: #A.
	b1 := FiChef nickname: #B.
	c1 := FiChef nickname: #C.

	self
		assertMergeBase: {a1} asFiSet
		withTarget: {a1} asFiSet
		andAncestor: {a1. b1} asFiSet
		equals: {a1} asFiSet
		conflicts: #()
]

{ #category : #tests }
FiThreeWayMergerTest >> test03SubtractiveConflictlessMerge [

	a1 := FiChef nickname: #A.
	b1 := FiChef nickname: #B.

	self
		assertMergeBase: {a1. b1} asFiSet
		withTarget: {} asFiSet
		andAncestor: {a1} asFiSet
		equals: {b1} asFiSet
		conflicts: #()
]

{ #category : #tests }
FiThreeWayMergerTest >> test04IdenticalModification [

	a1 := FiChef nickname: #A.
	b1 := FiChef nickname: #B.
	c1 := FiChef nickname: #C.

	a2 := a1 resultOf: (a1 editAt: #shortBio equal: '42').

	self
		assertMergeBase: {a2. b1} asFiSet
		withTarget: {a2. b1} asFiSet
		andAncestor: {a1. b1} asFiSet
		equals: {a2. b1} asFiSet
		conflicts: #()
]

{ #category : #tests }
FiThreeWayMergerTest >> test05ComplexConflictlessMerge [

	a1 := FiChef nickname: #A.
	b1 := FiChef nickname: #B.
	c1 := FiChef nickname: #C.

	a2 := a1 resultOf: (a1 editAt: #shortBio equal: '42').

	self
		assertMergeBase: {a1. b1. d1} asFiSet
		withTarget: {a2. c1} asFiSet
		andAncestor: {a1. c1. d1} asFiSet
		equals: {a2. b1} asFiSet
		conflicts: #()
]
