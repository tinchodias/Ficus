Extension { #name : #FiMethod }

{ #category : #'*FicusImpact' }
FiMethod >> messages [

	^ (RBParser parseMethod: sourceCode) sentMessages
]

{ #category : #'*FicusImpact' }
FiMethod >> messagesDo: aBlock [

	^ self messages do: aBlock
]
