Extension { #name : #FiShot }

{ #category : #'*FicusStore' }
FiShot >> isProxy [
	
	^ false
]

{ #category : #'*FicusStore' }
FiShot >> isPruned [

	self stepsAndValuesDo: [ :step :value |
		(value isShot not or: [ value isProxy ])
			ifFalse: [ ^ false ] ].
		
	^ true
]

{ #category : #'*FicusStore' }
FiShot >> proxyEquals: otherObject [
	
	otherObject isShot ifFalse: [ ^ false ].

	tag ifNotNil: [ tag = otherObject tag ifTrue: [ ^ true ] ].
	
	^ self = otherObject
]

{ #category : #'*FicusStore' }
FiShot >> pruned [

	^ self tag 
		ifNotNil: [ self taggedPruned ]
		ifNil: [ self untaggedPruned ]
	
]

{ #category : #'*FicusStore' }
FiShot >> taggedPruned [

	^ FiProxy new tag: self tag
]

{ #category : #'*FicusStore' }
FiShot >> untaggedPruned [

	| newStepsAndValues |
	newStepsAndValues := Dictionary new.
	
	self stepsAndValuesDo: [ :step :value | 
		newStepsAndValues 
			at: step pruned
			put: value pruned ].

	^ self species newFromStepsAndValues: newStepsAndValues
]
