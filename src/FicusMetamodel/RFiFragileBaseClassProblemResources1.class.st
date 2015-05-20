"
I add the method Log>>#log: to my superclass.
"
Class {
	#name : #RFiFragileBaseClassProblemResources1,
	#superclass : #RFiFragileBaseClassProblemResources0,
	#category : #'FicusMetamodel-Examples'
}

{ #category : #resources }
RFiFragileBaseClassProblemResources1 >> classLog [

	^ FiClass builder 
		name: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(msgs));
		category: self categoryNameLoggersCore;
		methods: {
			FiMethod sourceCode: 'messages  ^msgs'. 
			FiMethod sourceCode: 'log: msg  
	msgs add: msg'. 
			FiMethod sourceCode: 'initialize  
	msgs := LinkedList new.'.
			} asFiSet;
		new
]
