"
I know how to create set of Ficus Metalevel entities that exemplify the Fragile Base Problem.
"
Class {
	#name : #FiFragileBaseClassProblemResources,
	#superclass : #FiBaseResources,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseClassProblemResources >> classLog [

	^ FiClass builder 
		name: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(collection));
		methods: {
			FiMethod sourceCode: 'log: aMessage  
	collection add: aMessage'. 
			FiMethod sourceCode: 'logAll: messages  
	messages do: [:each | self log: each ]'. 
			FiMethod sourceCode: 'initialize  
	super initialize.
	collection := LinkedList new.'.
			} asFiSet;
		new
]

{ #category : #private }
FiFragileBaseClassProblemResources >> newFicusEnvironment [

	^ { self packageKernel. self packageCollections. self packageLoggers. } asFiSet
]

{ #category : #resources }
FiFragileBaseClassProblemResources >> packageLoggers [

	^ FiPackage builder
		name: #Loggers;
		contents: { self classLog } asFiSet;
		new
]
