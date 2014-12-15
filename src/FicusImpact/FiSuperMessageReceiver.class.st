Class {
	#name : #FiSuperMessageReceiver,
	#superclass : #FiMessageReceiver,
	#instVars : [
		'behaviorName'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #accessing }
FiSuperMessageReceiver >> behaviorName [
	
	^ behaviorName
]

{ #category : #lookup }
FiSuperMessageReceiver >> implementorsOf: aSelector in: anEnvironment [

	^ anEnvironment 
		implementorsOf: aSelector 
		inSuperclassesOf: (anEnvironment classNamed: behaviorName)
]

{ #category : #printing }
FiSuperMessageReceiver >> shortPrintString [

	^ 'super'
]
