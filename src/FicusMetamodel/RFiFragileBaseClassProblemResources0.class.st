"
I know how to create set of Ficus Metalevel entities that exemplify the Fragile Base Problem.
"
Class {
	#name : #RFiFragileBaseClassProblemResources0,
	#superclass : #RFiBaseResources,
	#category : #'FicusMetamodel-Examples'
}

{ #category : #resources }
RFiFragileBaseClassProblemResources0 >> categoryNameLoggersCore [

	^ 'Loggers-Core'
]

{ #category : #resources }
RFiFragileBaseClassProblemResources0 >> categoryNameLoggersTest [

	^ 'Loggers-Test'
]

{ #category : #resources }
RFiFragileBaseClassProblemResources0 >> classLog [

	^ FiClass builder 
		name: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameLoggersCore;
		methods: {
			FiMethod sourceCode: 'initialize  
	super initialize.
	collection := LinkedList new.'.
			} asFiSet;
		new
]

{ #category : #private }
RFiFragileBaseClassProblemResources0 >> newFicusEnvironment [

	^ { self packageKernel. self packageCollections. self packageLoggers. } asFiSet
]

{ #category : #resources }
RFiFragileBaseClassProblemResources0 >> packageLoggers [

	^ FiPackage builder
		name: #Loggers;
		contents: { self classLog } asFiSet;
		new
]
