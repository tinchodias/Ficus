Class {
	#name : #FiPossibleMethodInvocation,
	#superclass : #FiDependencyInterpretation,
	#instVars : [
		'methods'
	],
	#category : #'FicusImpact-Interpretations'
}

{ #category : #'instance creation' }
FiPossibleMethodInvocation class >> empty [

	^ self builder methods: FiSet new; new.
]

{ #category : #accessing }
FiPossibleMethodInvocation >> methods [
	
	^ methods
]
