Extension { #name : #RBNoClassCommentRule }

{ #category : #'*FicusRing-override' }
RBNoClassCommentRule >> checkClass: aContext [
	(aContext selectedClass isMeta or: [ aContext includesBehaviorNamed: #TestCase ])
		ifTrue: [ ^ self ].
	aContext selectedClass hasComment ifTrue: [ 
		result 
			addClass: aContext selectedClass; 
			addClass: aContext selectedClass class ]
]
