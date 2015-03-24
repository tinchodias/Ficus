"
I answer a variant of my superclass which adds the LRULog.
"
Class {
	#name : #FiFragileBaseClassProblemResourcesA,
	#superclass : #FiFragileBaseClassProblemResources,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseClassProblemResourcesA >> classLRULog [

	^ FiClass builder 
		name: #LRULog;
		superclassName: #Log;
		layout: (FiFixedLayout withInstanceVariables: #(tally));
		methods: {
			FiMethod sourceCode: 'log: aMessage  
	tally > 100 ifTrue: [ collection removeFirst ].
	super log: aMessage.
	tally := tally + 1.'. 
			FiMethod sourceCode: 'initialize  
	super initialize.
	tally := 0.'. 
			} asFiSet;
		new
]

{ #category : #resources }
FiFragileBaseClassProblemResourcesA >> packageLoggers [

	^ FiPackage builder
		name: #Loggers;
		contents: { self classLog. self classLRULog. } asFiSet;
		new
]
