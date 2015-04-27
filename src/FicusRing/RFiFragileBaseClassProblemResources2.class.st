"
My difference with my superclas is: 
* a refactoring to the method Log>>#log: 
* add a super-send to #initialize
"
Class {
	#name : #RFiFragileBaseClassProblemResources2,
	#superclass : #RFiFragileBaseClassProblemResources1,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
RFiFragileBaseClassProblemResources2 >> classLog [

	^ FiClass builder 
		name: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(collection));
		category: self categoryNameLoggersCore;
		methods: {
			FiMethod sourceCode: 'messages  ^collection'. 
			FiMethod sourceCode: 'log: aMessage  
	collection add: aMessage'. 
			FiMethod sourceCode: 'initialize  
	super initialize.
	collection := LinkedList new.'.
			} asFiSet;
		new
]
