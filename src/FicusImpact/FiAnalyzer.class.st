Class {
	#name : #FiAnalyzer,
	#superclass : #Object,
	#instVars : [
		'register',
		'sourceArray'
	],
	#category : #'FicusImpact-Old-Analyzer'
}

{ #category : #analysis }
FiAnalyzer >> analysisOf: aMethod levels: levels [

	| dependencies impact |

	"stop recursion"
	levels > 0 ifFalse: [ 
		^ FiNotAnalysedMethod builder
			hostName: aMethod methodClass name;
			isMeta: aMethod methodClass isMeta;
			selector: aMethod selector;
			sourceCode: (self sourceCodeFor: aMethod);
			new ].
	
	"continue recursion"
	dependencies := 
		aMethod messages 
			collect: [:selector |
				FiAnalysisPossibleMethodInvocation
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
			
	^ FiAnalysedMethod builder
		hostName: aMethod methodClass name;
		isMeta: aMethod methodClass isMeta;
		selector: aMethod selector;
		sourceCode: (self sourceCodeFor: aMethod);
		dependencies: dependencies asFiSet;
		impact: impact asFiSet;
		new

]

{ #category : #accessing }
FiAnalyzer >> register [

	^ register ifNil: [ register := SIRegister new fill; yourself ]
]

{ #category : #accessing }
FiAnalyzer >> register: anObject [

	register := anObject
]

{ #category : #accessing }
FiAnalyzer >> sourceArray [

	^ sourceArray ifNil: [ sourceArray := SourceFiles readOnlyCopy ]
]

{ #category : #accessing }
FiAnalyzer >> sourceArray: anObject [

	sourceArray := anObject
]

{ #category : #analysis }
FiAnalyzer >> sourceCodeFor: aMethod [

	"regular way?"
	aMethod hasSourcePointer ifFalse: [ ^ aMethod sourceCode ].
	
	"=> optimize"
	^ self sourceArray sourceCodeAt: aMethod sourcePointer.
]
