Extension { #name : #RBClassNotReferencedRule }

{ #category : #'*FicusRing' }
RBClassNotReferencedRule >> checkClass: aClass [ 
	(aClass isMeta or: [  aClass subclasses notEmpty or: [ aClass inheritsFrom: TestCase ] ] )
		ifTrue: [ ^ self ].
	aClass allCallsOn ifEmpty: [
		result
			addClass: aClass;
			addClass: aClass classSide ]
]
