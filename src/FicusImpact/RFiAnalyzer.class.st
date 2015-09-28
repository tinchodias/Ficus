Class {
	#name : #RFiAnalyzer,
	#superclass : #Object,
	#instVars : [
		'register',
		'sourceArray'
	],
	#category : #'FicusImpact-Old-Analyzer'
}

{ #category : #analysis }
RFiAnalyzer >> analysisOf: aMethod levels: levels [

	| dependencies impact |

	"stop recursion"
	levels > 0 ifFalse: [ 
		^ RFiNotAnalysedMethod builder
			hostName: aMethod methodClass name;
			isMeta: aMethod methodClass isMeta;
			selector: aMethod selector;
			sourceCode: (self sourceCodeFor: aMethod);
			new ].
	
	"continue recursion"
	dependencies := 
		aMethod messages 
			collect: [:selector |
				RFiAnalysisPossibleMethodInvocation
					sending: selector "///(FiMessageSend of: selector)"
					toAnyOf: 
						((self register implementorsOf: selector) 
							collect: [ :anImpl | self analysisOf: anImpl levels: levels-1] 
							as: Array) asFiSet ] 
			as: Array.

	impact := 
		(self register sendersOf: aMethod selector)
			collect: [:senderMethod | self analysisOf: senderMethod levels: levels-1 ] 
			as: Array.
			
	^ RFiAnalysedMethod builder
		hostName: aMethod methodClass name;
		isMeta: aMethod methodClass isMeta;
		selector: aMethod selector;
		sourceCode: (self sourceCodeFor: aMethod);
		dependencies: dependencies asFiSet;
		impact: impact asFiSet;
		new

]

{ #category : #accessing }
RFiAnalyzer >> register [

	^ register ifNil: [ register := SIRegister new fill; yourself ]
]

{ #category : #accessing }
RFiAnalyzer >> register: anObject [

	register := anObject
]

{ #category : #accessing }
RFiAnalyzer >> sourceArray [

	^ sourceArray ifNil: [ sourceArray := SourceFiles readOnlyCopy ]
]

{ #category : #accessing }
RFiAnalyzer >> sourceArray: anObject [

	sourceArray := anObject
]

{ #category : #analysis }
RFiAnalyzer >> sourceCodeFor: aMethod [

	"regular way?"
	aMethod hasSourcePointer ifFalse: [ ^ aMethod sourceCode ].
	
	"=> optimize"
	^ self sourceArray sourceCodeAt: aMethod sourcePointer.
]
