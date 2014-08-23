"
I implement a cache for FiShot instances.
"
Class {
	#name : #FiShotCache,
	#superclass : #Object,
	#instVars : [
		'cacheByClass'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'Ficus-Model-Builder'
}

{ #category : #accessing }
FiShotCache class >> default [
	
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #accessing }
FiShotCache class >> reset [
	"self reset"
	
	^ defaultInstance := nil
]

{ #category : #initialization }
FiShotCache >> initialize [

	super initialize.
	
	cacheByClass := IdentityDictionary new.
]

{ #category : #accessing }
FiShotCache >> like: aShot [

	| aWeakSet |
	aWeakSet := 
		cacheByClass 
			at: aShot class
			ifAbsentPut: [ WeakSet new ].

	^ aWeakSet 
		like: aShot 
		ifAbsent: [ 
			aWeakSet add: aShot.
			aShot ]
]
