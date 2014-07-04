Class {
	#name : #FiVariableBinding,
	#superclass : #FiDependencyInterpretation,
	#instVars : [
		'target'
	],
	#category : #'FicusImpact-Interpretations'
}

{ #category : #'instance creation' }
FiVariableBinding class >> undeclared [

	self flag: #todo. "fix"
	
	^ FiVariableBinding new
]

{ #category : #accessing }
FiVariableBinding >> target [
	
	^ target
]
