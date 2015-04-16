"
I answer a variant of my superclass which improves a test in LRULogTest.
"
Class {
	#name : #RFiFragileBaseClassProblemResources5A,
	#superclass : #RFiFragileBaseClassProblemResources4A,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
RFiFragileBaseClassProblemResources5A >> classLRULogTest [

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
			FiMethod sourceCode: 'testLogAll
	| log |
	log := LRULog new.
	log logAll: #(hello bonjour).
	self assert: log tally = 2.'.
			} asFiSet;
		new
]
