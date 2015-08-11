"
I answer a variant of my superclass which modifies Log>>logAll:.
"
Class {
	#name : #RFiFragileBaseClassProblemResources4B,
	#superclass : #RFiFragileBaseClassProblemResources3,
	#category : #'FicusMetamodel-Examples'
}

{ #category : #resources }
RFiFragileBaseClassProblemResources4B >> classLog [

	^ FiClass builder 
		name: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(collection));
		category: self categoryNameLoggersCore;
		methods: {
			FiMethod sourceCode: 'messages  ^collection'. 
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
