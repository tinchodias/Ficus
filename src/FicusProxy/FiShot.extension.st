Extension { #name : #FiShot }

{ #category : #'*FicusProxy' }
FiShot >> hasTag [

	^ self tag isNotNil
]

{ #category : #'*FicusProxy' }
FiShot >> isProxy [
	
	^ false
]

{ #category : #'*FicusProxy' }
FiShot >> isPruned [

	self stepsAndValuesDo: [ :step :value |
		(value isShot not or: [ value isProxy ])
			ifFalse: [ ^ false ] ].
		
	^ true
]

{ #category : #'*FicusProxy' }
FiShot >> printOn: aStream [

	super printOn: aStream.

	self tag ifNil: [ ^ self ].

	aStream 
		space;
		nextPut: $[.

	self tag printOn: aStream.

	aStream 
		nextPut: $];
		space.
]

{ #category : #'*FicusProxy' }
FiShot >> proxyEquals: otherObject [
	
	otherObject isShot ifFalse: [ ^ false ].

	tag ifNotNil: [ tag = otherObject tag ifTrue: [ ^ true ] ].
	
	^ self = otherObject
]

{ #category : #'*FicusProxy' }
FiShot >> pruned [

	^ self tag 
		ifNotNil: [ self taggedPruned ]
		ifNil: [ self untaggedPruned ]
	
]

{ #category : #'*FicusProxy' }
FiShot >> tag [
	
	^ tag
]

{ #category : #'*FicusProxy' }
FiShot >> tag: anObject [

	tag := anObject
]

{ #category : #'*FicusProxy' }
FiShot >> taggedPruned [

	^ FiProxy new tag: self tag
]

{ #category : #'*FicusProxy' }
FiShot >> untaggedPruned [

	| newStepsAndValues |
	newStepsAndValues := Dictionary new.
	
	self stepsAndValuesDo: [ :step :value | 
		newStepsAndValues 
			at: step pruned
			put: value pruned ].

	^ self species newFromStepsAndValues: newStepsAndValues
]
