"
I represent a behavior. I have some common implementation of class and metaclass representations.
"
Class {
	#name : #FiBehavior,
	#superclass : #FiFixedObject,
	#instVars : [
		'layout',
		'methods'
	],
	#category : #'Ficus-Model-Meta'
}

{ #category : #initialization }
FiBehavior >> initialize [

	super initialize.
	
	methods := FiSet new.
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
