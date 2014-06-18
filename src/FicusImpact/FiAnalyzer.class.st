Class {
	#name : #FiAnalyzer,
	#superclass : #Object,
	#instVars : [
		'register'
	],
	#category : #FicusImpact
}

{ #category : #'as yet unclassified' }
FiAnalyzer >> analysisOf: aMethod levels: levels [

	| dependencies |

	"stop recursion"
	levels > 0 ifFalse: [ 
		^ FiNotAnalysedMethod new
			hostName: aMethod methodClass name;
			isMeta: aMethod methodClass isMeta;
			selector: aMethod selector;
			sourceCode: aMethod sourceCode;
			yourself ].
	
	"continue recursion"
	dependencies := 
		aMethod messages 
			collect: [:selector |
				FiPossibleMethodInvocation
					sending: selector "///(FiMessageSend of: selector)"
					toAnyOf: 
						(FiSet withValues: ((register implementorsOf: selector) 
							collect: [ :anImpl | self analysisOf: anImpl levels: levels-1] 
							as: Array)) ] 
			as: Array.
			
	^ FiAnalysedMethod new
		hostName: aMethod methodClass name;
		isMeta: aMethod methodClass isMeta;
		selector: aMethod selector;
		sourceCode: aMethod sourceCode;
		dependencies: (FiSet withValues: dependencies);
		yourself

]

{ #category : #initialization }
FiAnalyzer >> initialize [

	super initialize.
	
	register := SIRegister new fill; yourself.

]
