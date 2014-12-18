Class {
	#name : #FiInheritance,
	#superclass : #FiDependencyInterpretation,
	#instVars : [
		'target'
	],
	#category : #'FicusImpact-Interpretations'
}

{ #category : #'instance creation' }
FiInheritance class >> notFound [

	self flag: #todo. "fix"
	
	^ self new
]

{ #category : #accessing }
FiInheritance >> target [
	
	^ target
]
