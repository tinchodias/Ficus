Class {
	#name : #FiPossibleMethodInvocation,
	#superclass : #FiFixedObject,
	#instVars : [
		'messageSend',
		'methods'
	],
	#category : #'FicusImpact-Prototype'
}

{ #category : #'instance creation' }
FiPossibleMethodInvocation class >> sending: aMessageSend toAnyOf: aCollection [ 
	
	^ self new
		messageSend: aMessageSend;
		methods: aCollection;
		yourself

]

{ #category : #accessing }
FiPossibleMethodInvocation >> defaultStep [
	
	^ messageSend asString asSymbol
]

{ #category : #accessing }
FiPossibleMethodInvocation >> messageSend: aMessageSend [

	messageSend := aMessageSend 
]

{ #category : #accessing }
FiPossibleMethodInvocation >> methods: aCollection [ 
	
	methods := aCollection
]
