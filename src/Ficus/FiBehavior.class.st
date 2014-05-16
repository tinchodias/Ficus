Class {
	#name : #FiBehavior,
	#superclass : #FiShot,
	#instVars : [
		'layout',
		'methods'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #initialization }
FiBehavior >> initialize [

	super initialize.
	
	methods := FiDictionary new.
	layout := FiFixedLayout new.
]

{ #category : #testing }
FiBehavior >> isMeta [

	^ self subclassResponsibility
]

{ #category : #accessing }
FiBehavior >> layout [
	
	^ layout
]

{ #category : #accessing }
FiBehavior >> layout: anObject [
	
	layout := anObject
]

{ #category : #accessing }
FiBehavior >> methods [
	
	^ methods
]

{ #category : #accessing }
FiBehavior >> methods: anObject [
	
	methods := anObject
]
