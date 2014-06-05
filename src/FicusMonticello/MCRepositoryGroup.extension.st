Extension { #name : #MCRepositoryGroup }

{ #category : #'*FicusMonticello' }
MCRepositoryGroup >> allVersionNames [

	| result |
	result := Set new.

	self repositoriesDo: [ :each | result addAll: each allVersionNames ].

	^ result
]
