"
My difference with my superclas is: 
* a refactoring to the method Log>>#log: 
* add a super-send to #initialize
"
Class {
	#name : #FiFragileBaseClassProblemResources2,
	#superclass : #FiFragileBaseClassProblemResources1,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseClassProblemResources2 >> classLog [

	^ FiClass builder 
		name: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(collection));
		methods: {
			FiMethod sourceCode: 'log: aMessage  
	collection add: aMessage'. 
			FiMethod sourceCode: 'initialize  
	super initialize.
	collection := LinkedList new.'.
			} asFiSet;
		new
]
