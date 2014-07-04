Class {
	#name : #FiPossibleMethodInvocation,
	#superclass : #FiDependency,
	#instVars : [
		'methods'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #'instance creation' }
FiPossibleMethodInvocation class >> sending: aMessageSend toAnyOf: aCollection [ 
	
	^ self builder
		messageSend: aMessageSend;
		methods: aCollection;
		new

]

{ #category : #accessing }
FiPossibleMethodInvocation >> defaultStep [
	
	^ messageSend asString asSymbol
]

{ #category : #accessing }
FiPossibleMethodInvocation >> messageSend [
	
	^ messageSend
]

{ #category : #accessing }
FiPossibleMethodInvocation >> methods [
	
	^ methods
]
