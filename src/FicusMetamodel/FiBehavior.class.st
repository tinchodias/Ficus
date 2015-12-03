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
	#category : #'FicusMetamodel-Core'
}

{ #category : #initialization }
FiBehavior >> initialize [

	super initialize.
	
	methods := FiSet new.
	layout := FiFixedLayout new.
]

{ #category : #printing }
FiBehavior >> instanceVariablesString [

	^ Character space join: (layout instanceVariableNames collect: #asString)
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
FiBehavior >> methods [
	
	^ methods
]
