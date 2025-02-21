Extension { #name : #RBNoClassCommentRule }

{ #category : #'*FicusRing-override' }
RBNoClassCommentRule >> checkClass: aClass [
	(aClass isMeta or: [ aClass isTestCase ])
		ifTrue: [ ^ self ].
	aClass hasComment ifFalse: [ 
		result 
			addClass: aClass; 
			addClass: aClass theMetaClass ]
]
