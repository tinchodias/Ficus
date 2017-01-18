Extension { #name : #RBUnaryAccessingMethodWithoutReturnRule }

{ #category : #'*Ficus-running' }
RBUnaryAccessingMethodWithoutReturnRule >> basicCheck: aMethod [
	(aMethod numArgs > 0 or: [ aMethod isAbstract ])
		ifTrue: [ ^ false ].
				
	(aMethod protocol asString beginsWith: #accessing)
		ifFalse: [ ^ false ].
	aMethod parseTree
		nodesDo: [ :each | 
			each isReturn
				ifTrue: [ ^ false ] ].
	^ true
]
