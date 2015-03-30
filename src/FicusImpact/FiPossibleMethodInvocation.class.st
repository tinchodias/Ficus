Class {
	#name : #FiPossibleMethodInvocation,
	#superclass : #FiDependency,
	#instVars : [
		'methods'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #'instance creation' }
FiPossibleMethodInvocation class >> empty [

	^ self builder methods: FiSet new; new.
]

{ #category : #'instance creation' }
FiPossibleMethodInvocation class >> methods: possibleInvocations [

	^ FiPossibleMethodInvocation basicNew
		initializeWithMethods: possibleInvocations asFiSet;
		yourself
]

{ #category : #initialization }
FiPossibleMethodInvocation >> initializeWithMethods: possibleInvocations [

	self initialize.
	
	methods := possibleInvocations
]

{ #category : #accessing }
FiPossibleMethodInvocation >> methods [
	
	^ methods
]

{ #category : #printing }
FiPossibleMethodInvocation >> printOn: aStream [

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
FiPossibleMethodInvocation >> targets [
	
	^ methods asArray
]
