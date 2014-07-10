Extension { #name : #FiMethod }

{ #category : #'*FicusImpact' }
FiMethod >> messages [

	| visitor |
	visitor := FiSentSelectorsCollector new.
	(RBParser parseMethod: sourceCode) acceptVisitor: visitor.
	
	^ visitor selectors
]

{ #category : #'*FicusImpact' }
FiMethod >> messagesDo: aBlock [

	^ self messages do: aBlock
]
