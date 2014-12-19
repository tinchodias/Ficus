"
I answer a variant of my superclass which adds the LRULog.
"
Class {
	#name : #FiFragileBaseProblemResourcesA,
	#superclass : #FiFragileBaseProblemResources,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseProblemResourcesA >> classLRULog [

	^ FiClass builder 
		theName: #LRULog;
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
FiFragileBaseProblemResourcesA >> packageLog [

	^ FiPackage builder
		theName: #Log;
		contents: { self classLog. self classLRULog. } asFiSet;
		new
]
