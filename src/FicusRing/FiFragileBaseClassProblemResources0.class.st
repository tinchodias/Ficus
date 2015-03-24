"
I know how to create set of Ficus Metalevel entities that exemplify the Fragile Base Problem.
"
Class {
	#name : #FiFragileBaseClassProblemResources0,
	#superclass : #FiBaseResources,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseClassProblemResources0 >> classLog [

	^ FiClass builder 
		name: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {
			FiMethod sourceCode: 'initialize  
	super initialize.
	collection := LinkedList new.'.
			} asFiSet;
		new
]

{ #category : #private }
FiFragileBaseClassProblemResources0 >> newFicusEnvironment [

	^ { self packageKernel. self packageCollections. self packageLoggers. } asFiSet
]

{ #category : #resources }
FiFragileBaseClassProblemResources0 >> packageLoggers [

	^ FiPackage builder
		name: #Loggers;
		contents: { self classLog } asFiSet;
		new
]
