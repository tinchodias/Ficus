Class {
	#name : #RFiPossibleMethodInvocation,
	#superclass : #RFiDependency,
	#instVars : [
		'methods'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #'instance creation' }
RFiPossibleMethodInvocation class >> empty [

	^ self builder methods: FiSet new; new.
]

{ #category : #'instance creation' }
RFiPossibleMethodInvocation class >> methods: possibleInvocations [

	^ RFiPossibleMethodInvocation basicNew
		initializeWithMethods: possibleInvocations asFiSet;
		yourself
]

{ #category : #initialization }
RFiPossibleMethodInvocation >> initializeWithMethods: possibleInvocations [

	self initialize.
	
	methods := possibleInvocations
]

{ #category : #accessing }
RFiPossibleMethodInvocation >> methods [
	
	^ methods
]

{ #category : #printing }
RFiPossibleMethodInvocation >> printOn: aStream [

	| limit |
	super printOn: aStream.
	
	aStream nextPut: $(.

	limit := 3.
	methods size > limit 
		ifTrue: [ 
			(methods asArray first: limit)
				do: [:element | element shortPrintOn: aStream ] 
				separatedBy: [ aStream space ].
			aStream 
				nextPutAll: ' + ';
				print: (methods size - limit);
				nextPutAll: ' more' ]
		ifFalse: [
			methods asArray
				do: [:element | element shortPrintOn: aStream ] 
				separatedBy: [ aStream space ] ].
			
	aStream nextPut: $).
]

{ #category : #accessing }
RFiPossibleMethodInvocation >> targets [
	
	^ methods asArray
]
