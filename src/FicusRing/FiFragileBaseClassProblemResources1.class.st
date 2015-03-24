"
I add the method Log>>#log: to my superclass.
"
Class {
	#name : #FiFragileBaseClassProblemResources1,
	#superclass : #FiFragileBaseClassProblemResources0,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseClassProblemResources1 >> classLog [

	^ FiClass builder 
		name: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(msgs));
		methods: {
			FiMethod sourceCode: 'log: msg  
	msgs add: msg'. 
			FiMethod sourceCode: 'initialize  
	msgs := LinkedList new.'.
			} asFiSet;
		new
]
