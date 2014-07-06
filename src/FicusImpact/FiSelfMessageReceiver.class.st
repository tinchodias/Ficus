Class {
	#name : #FiSelfMessageReceiver,
	#superclass : #FiMessageReceiver,
	#instVars : [
		'behaviorName'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #accessing }
FiSelfMessageReceiver >> behaviorName [
	
	^ behaviorName
]

{ #category : #lookup }
FiSelfMessageReceiver >> implementorsOf: aSelector in: anEnvironment [

	^ anEnvironment 
		implementorsOf: aSelector 
		inHierarchyOf: (anEnvironment classNamed: behaviorName)
]
