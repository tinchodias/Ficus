"
I answer a variant of my superclass which modifies Log>>logAll:.
"
Class {
	#name : #FiFragileBaseClassProblemResources4B,
	#superclass : #FiFragileBaseClassProblemResources3,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseClassProblemResources4B >> classLog [

	^ FiClass builder 
		name: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(collection));
		category: self categoryNameLoggersCore;
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
