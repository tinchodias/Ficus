"
I answer a variant of my superclass which improves a test in FilteredLogTest.
"
Class {
	#name : #RFiFragileBaseClassProblemResources5A,
	#superclass : #RFiFragileBaseClassProblemResources4A,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
RFiFragileBaseClassProblemResources5A >> classFilteredLogTest [

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
			FiMethod sourceCode: 'testLogAll
	| log |
	log := FilteredLog new.
	log filterBlock: [ :each | each > 0 ].

	log logAll: #(5 7).
	self assert: log messages size = 2.'.
			} asFiSet;
		new
]
