"
I implement a 3-way merge algorithm for FiShots.
"
Class {
	#name : #FiThreeWayMerger,
	#superclass : #Object,
	#instVars : [
		'base',
		'target',
		'ancestor'
	],
	#category : #'FicusExtras-Model-Merge'
}

{ #category : #'instance creation' }
FiThreeWayMerger class >> base: aBaseShot target: aTargetShot ancestor: anAncestorShot [
	
	^ self basicNew 
		initializeWithBase: aBaseShot target: aTargetShot ancestor: anAncestorShot;
		yourself
]

{ #category : #accessing }
FiThreeWayMerger >> conflicts [
	
	^ #() "Mock"
]

{ #category : #initialization }
FiThreeWayMerger >> initializeWithBase: aBaseShot target: aTargetShot ancestor: anAncestorShot [
	
	self initialize.
	
	base := aBaseShot.
	target := aTargetShot.
	ancestor := anAncestorShot.
]

{ #category : #merging }
FiThreeWayMerger >> result [
	
	| baseDiff targetDiff targetPlusBase basePlusTarget |
	baseDiff := base differenceFrom: ancestor.
	targetDiff := target differenceFrom: ancestor.
	
	targetPlusBase := target resultOf: baseDiff edit.
	basePlusTarget := base resultOf: targetDiff edit.
	
	targetPlusBase = basePlusTarget ifFalse: [ self shouldBeImplemented "conflicts!" ].
	
	^ targetPlusBase 
]
