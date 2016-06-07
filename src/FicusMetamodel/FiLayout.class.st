"
I represent an abstract FiBehavior's layout.
"
Class {
	#name : #FiLayout,
	#superclass : #FiFixedObject,
	#category : #'FicusMetamodel-Core'
}

{ #category : #printing }
FiLayout >> instanceVariableNames [
	
	^ #()
]

{ #category : #accessing }
FiLayout >> instanceVariables [
	
	^ #()
]

{ #category : #testing }
FiLayout >> isBitsLayout [
	
	^ false
]

{ #category : #testing }
FiLayout >> isBytesLayout [
	
	^ false
]

{ #category : #testing }
FiLayout >> isCompiledMethodLayout [
	
	^ false
]

{ #category : #testing }
FiLayout >> isEphemeronLayout [
	
	^ false
]

{ #category : #testing }
FiLayout >> isFixedLayout [
	
	^ false
]

{ #category : #testing }
FiLayout >> isVariableLayout [
	
	^ false
]

{ #category : #testing }
FiLayout >> isWeakLayout [
	
	^ false
]

{ #category : #testing }
FiLayout >> isWordsLayout [
	
	^ false
]
