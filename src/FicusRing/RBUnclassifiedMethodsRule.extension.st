Extension { #name : #RBUnclassifiedMethodsRule }

{ #category : #'*FicusRing' }
RBUnclassifiedMethodsRule >> checkMethod: aMethod [ 

	aMethod protocol = Protocol unclassified 
		ifTrue: [ result addMethod: aMethod ]
]
