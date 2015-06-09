Extension { #name : #RBUnclassifiedMethodsRule }

{ #category : #'*FicusRing-override' }
RBUnclassifiedMethodsRule >> checkMethod: aMethod [ 

	aMethod protocol = Protocol unclassified 
		ifTrue: [ result addMethod: aMethod ]
]
