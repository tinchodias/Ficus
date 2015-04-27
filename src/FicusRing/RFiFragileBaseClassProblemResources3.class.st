"
My difference with my superclas is: 
* add Log>>#logAll: 
"
Class {
	#name : #RFiFragileBaseClassProblemResources3,
	#superclass : #RFiFragileBaseClassProblemResources2,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
RFiFragileBaseClassProblemResources3 >> classLog [

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
	messages do: [:each | self log: each ]'. 
			FiMethod sourceCode: 'initialize  
	super initialize.
	collection := LinkedList new.'.
			} asFiSet;
		new
]
