Class {
	#name : #RFiAnalyzerCache,
	#superclass : #RFiAnalyzer,
	#instVars : [
		'cache'
	],
	#category : #'FicusImpact-Old-Analyzer'
}

{ #category : #analysis }
RFiAnalyzerCache >> analysisOf: aMethod levels: levels [

	^ cache 
		at: aMethod methodClass asString, aMethod selector, '-', levels asString
		ifAbsentPut: [ super analysisOf: aMethod levels: levels ]
]

{ #category : #initialization }
RFiAnalyzerCache >> initialize [

	super initialize.
	
	cache := Dictionary new.
]
