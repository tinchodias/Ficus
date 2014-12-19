"
I answer a variant of my superclass which modifies Log>>logAll:.
"
Class {
	#name : #FiFragileBaseProblemResourcesB,
	#superclass : #FiFragileBaseProblemResources,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseProblemResourcesB >> classLog [

	^ FiClass builder 
		theName: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(collection));
		methods: {
			FiMethod sourceCode: 'log: aMessage  
	collection add: aMessage'. 
			FiMethod sourceCode: 'logAll: messages  
	collection addAll: messages'. 
			FiMethod sourceCode: 'initialize  
	super initialize.
	collection := LinkedList new.'.
			} asFiSet;
		new
]
