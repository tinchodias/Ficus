Class {
	#name : #FiPossibleMethodInvocation,
	#superclass : #FiDependency,
	#instVars : [
		'methods'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #'instance creation' }
FiPossibleMethodInvocation class >> empty [

	^ self builder methods: FiSet new; new.
]

{ #category : #accessing }
FiPossibleMethodInvocation >> methods [
	
	^ methods
]

{ #category : #printing }
FiPossibleMethodInvocation >> printOn: aStream [
	
	super printOn: aStream.
	
	aStream nextPut: $(.
	methods values 
		do: [:element | element shortPrintOn: aStream ] 
		separatedBy: [ aStream space ].
	aStream nextPut: $).
]
