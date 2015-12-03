Extension { #name : #RBUnaryAccessingMethodWithoutReturnRule }

{ #category : #'*Ficus-running' }
RBUnaryAccessingMethodWithoutReturnRule >> basicCheck: aMethod [
	aMethod numArgs = 0 ifFalse: [ ^ false ].
	aMethod isAbstract ifTrue: [ ^ false ].
	aMethod protocol = #accessing ifFalse: [ ^ false ].
	^ aMethod parseTree statements noneSatisfy: [ :each | 
			each isReturn ].
]
