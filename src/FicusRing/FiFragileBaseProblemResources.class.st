"
I know how to create set of Ficus Metalevel entities that exemplify the Fragile Base Problem.
"
Class {
	#name : #FiFragileBaseProblemResources,
	#superclass : #FiBaseResources,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseProblemResources >> classLog [

	^ FiClass builder 
		theName: #Log;
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

{ #category : #resources }
FiFragileBaseProblemResources >> environmentWithAll [

	^ { self packageKernel. self packageCollections. self packageLog. } asFiSet
]

{ #category : #resources }
FiFragileBaseProblemResources >> packageLog [

	^ FiPackage builder
		theName: #Log;
		contents: { self classLog } asFiSet;
		new
]
