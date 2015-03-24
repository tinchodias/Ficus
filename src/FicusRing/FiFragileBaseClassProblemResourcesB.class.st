"
I answer a variant of my superclass which modifies Log>>logAll:.
"
Class {
	#name : #FiFragileBaseClassProblemResourcesB,
	#superclass : #FiFragileBaseClassProblemResources,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseClassProblemResourcesB >> classLog [

	^ FiClass builder 
		name: #Log;
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
