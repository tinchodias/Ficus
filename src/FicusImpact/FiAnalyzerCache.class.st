Class {
	#name : #FiAnalyzerCache,
	#superclass : #FiAnalyzer,
	#instVars : [
		'cache'
	],
	#category : #'FicusImpact-Analyzer'
}

{ #category : #analysis }
FiAnalyzerCache >> analysisOf: aMethod levels: levels [

	^ cache 
		at: aMethod methodClass asString, aMethod selector, '-', levels asString
		ifAbsentPut: [ super analysisOf: aMethod levels: levels ]
]

{ #category : #initialization }
FiAnalyzerCache >> initialize [

	super initialize.
	
	cache := Dictionary new.
]
