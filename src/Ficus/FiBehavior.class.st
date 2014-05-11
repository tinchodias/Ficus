Class {
	#name : #FiBehavior,
	#superclass : #FiShot,
	#instVars : [
		'superclass',
		'layout',
		'methods'
	],
	#category : #'Ficus-Model-Meta'
}

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

{ #category : #accessing }
FiBehavior >> superclass [
	
	^ superclass
]

{ #category : #accessing }
FiBehavior >> superclass: anObject [
	
	superclass := anObject
]
