"
I answer a variant of my superclass which improves a test in LRULogTest.
"
Class {
	#name : #FiFragileBaseClassProblemResources5A,
	#superclass : #FiFragileBaseClassProblemResources4A,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseClassProblemResources5A >> classLRULogTest [

	^ FiClass builder 
		name: #LRULogTest;
		superclassName: #Log;
		layout: (FiFixedLayout withInstanceVariables: #());
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
