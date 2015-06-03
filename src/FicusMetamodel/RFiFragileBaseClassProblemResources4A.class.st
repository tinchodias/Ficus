"
I answer a variant of my superclass which adds the FilteredLog, with a test.
"
Class {
	#name : #RFiFragileBaseClassProblemResources4A,
	#superclass : #RFiFragileBaseClassProblemResources3,
	#category : #'FicusMetamodel-Examples'
}

{ #category : #resources }
RFiFragileBaseClassProblemResources4A >> classFilteredLog [

	^ FiClass builder 
		name: #FilteredLog;
		superclassName: #Log;
		layout: (FiFixedLayout withInstanceVariableNames: #(filterBlock));
		category: self categoryNameLoggersCore;
		methods: {
			FiMethod sourceCode: 'filterBlock  ^filterBlock'.
			FiMethod sourceCode: 'filterBlock: aBlock  filterBlock := aBlock'.
			FiMethod sourceCode: 'log: aMessage  
	(filterBlock value: aMessage) 
		ifTrue: [ super log: aMessage ].'. 
			FiMethod sourceCode: 'initialize  
	super initialize.
	filterBlock := [ :each | true ].'. 
			} asFiSet;
		new
]

{ #category : #resources }
RFiFragileBaseClassProblemResources4A >> classFilteredLogTest [

	^ FiClass builder 
		name: #FilteredLogTest;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameLoggersTest;
		methods: {
			FiMethod sourceCode: 'testLog
	| log |
	log := FilteredLog new.
	log filterBlock: [ :each | each > 0 ].

	log log: -1.
	self assert: log messages isEmpty.

	log log: 5.
	self assert: log messages size = 1.
	'.
			FiMethod sourceCode: 'testLogAll  "TODO"'.
			} asFiSet;
		new
]

{ #category : #resources }
RFiFragileBaseClassProblemResources4A >> packageLoggers [

	^ FiPackage builder
		name: #Loggers;
		contents: { self classLog. self classFilteredLog. self classFilteredLogTest. } asFiSet;
		new
]
