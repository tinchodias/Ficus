Class {
	#name : #FiAnalysisPossibleMethodInvocation,
	#superclass : #FiFixedObject,
	#instVars : [
		'messageSend',
		'methods'
	],
	#category : #'FicusImpact-Old-Analyzer'
}

{ #category : #'instance creation' }
FiAnalysisPossibleMethodInvocation class >> sending: aMessageSend toAnyOf: aCollection [ 
	
	^ self builder
		messageSend: aMessageSend;
		methods: aCollection;
		new

]

{ #category : #accessing }
FiAnalysisPossibleMethodInvocation >> defaultStep [
	
	^ messageSend asString asSymbol
]

{ #category : #accessing }
FiAnalysisPossibleMethodInvocation >> messageSend [
	
	^ messageSend
]

{ #category : #accessing }
FiAnalysisPossibleMethodInvocation >> methods [
	
	^ methods
]
