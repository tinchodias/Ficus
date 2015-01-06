Class {
	#name : #FiGraph,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'FicusImpact-Graph'
}

{ #category : #accessing }
FiGraph >> environment: aFiRGEnvironment [ 
	
	environment := aFiRGEnvironment 
]

{ #category : #accessing }
FiGraph >> nodeFor: aFiRGObject [ 
	
	^ FiNode new
		graph: self;
		contents: aFiRGObject;
		yourself
]
