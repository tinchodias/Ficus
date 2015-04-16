Class {
	#name : #RFiAnalysisPossibleMethodInvocation,
	#superclass : #FiFixedObject,
	#instVars : [
		'messageSend',
		'methods'
	],
	#category : #'FicusImpact-Old-Analyzer'
}

{ #category : #'instance creation' }
RFiAnalysisPossibleMethodInvocation class >> sending: aMessageSend toAnyOf: aCollection [ 
	
	^ self builder
		messageSend: aMessageSend;
		methods: aCollection;
		new

]

{ #category : #accessing }
RFiAnalysisPossibleMethodInvocation >> defaultStep [
	
	^ messageSend asString asSymbol
]

{ #category : #accessing }
RFiAnalysisPossibleMethodInvocation >> messageSend [
	
	^ messageSend
]

{ #category : #accessing }
RFiAnalysisPossibleMethodInvocation >> methods [
	
	^ methods
]
