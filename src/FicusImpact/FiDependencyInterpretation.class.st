Class {
	#name : #FiDependencyInterpretation,
	#superclass : #FiFixedObject,
	#category : #'FicusImpact-Interpretations'
}

{ #category : #printing }
FiDependencyInterpretation >> printOn: aStream [
	"A default print string"
	
	super printOn: aStream.
	
	self stepCount = 1 ifTrue: [
		aStream 
			nextPut: $(;
			print: self values anyOne;
			nextPut: $). ]
]
