"
I implement a cache for FiObject instances.
"
Class {
	#name : #FiObjectCache,
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
FiObjectCache class >> default [
	
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #accessing }
FiObjectCache class >> reset [
	"self reset"
	
	^ defaultInstance := nil
]

{ #category : #initialization }
FiObjectCache >> initialize [

	super initialize.
	
	cacheByClass := IdentityDictionary new.
]

{ #category : #accessing }
FiObjectCache >> like: anObject [

	| aWeakSet |
	aWeakSet := 
		cacheByClass 
			at: anObject class
			ifAbsentPut: [ WeakSet new ].

	^ aWeakSet 
		like: anObject 
		ifAbsent: [ 
			aWeakSet add: anObject.
			anObject ]
]

{ #category : #accessing }
FiObjectCache >> size [
	
	^ cacheByClass inject: 0 into: [ :sum :aWeakSet | sum + aWeakSet slowSize ]
]
