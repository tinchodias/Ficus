"
I answer a variant of my superclass which adds the LRULog, with a test.
"
Class {
	#name : #FiFragileBaseClassProblemResources4A,
	#superclass : #FiFragileBaseClassProblemResources3,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseClassProblemResources4A >> classLRULog [

	^ FiClass builder 
		name: #LRULog;
		superclassName: #Log;
		layout: (FiFixedLayout withInstanceVariables: #(tally));
		category: self categoryNameLoggersCore;
		methods: {
			FiMethod sourceCode: 'tally  ^tally'. 
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
FiFragileBaseClassProblemResources4A >> classLRULogTest [

	^ FiClass builder 
		name: #LRULogTest;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameLoggersTest;
		methods: {
			FiMethod sourceCode: 'testLog
	| log |
	log := LRULog new.
	log log: #bonjour.
	self assert: log tally = 1.'.
			FiMethod sourceCode: 'testLogAll  "TODO"'.
			} asFiSet;
		new
]

{ #category : #resources }
FiFragileBaseClassProblemResources4A >> packageLoggers [

	^ FiPackage builder
		name: #Loggers;
		contents: { self classLog. self classLRULog. self classLRULogTest. } asFiSet;
		new
]
