Extension { #name : #YrCommitRoundTripTest }

{ #category : #'*FicusMonticelloYrupe' }
YrCommitRoundTripTest >> testFicusDictionary [

	| dictionary |
	dictionary := FiDictionary new.	
	dictionary := dictionary resultOf: (dictionary editAt: #A equal: 42).

	self assertRoundTripEquals: dictionary.
]

{ #category : #'*FicusMonticelloYrupe' }
YrCommitRoundTripTest >> testNestedFicusDictionary [

	| nestedDictionary dictionary |
	nestedDictionary := FiDictionary new.	
	nestedDictionary := nestedDictionary resultOf: (nestedDictionary editAt: #B equal: 42).
	dictionary := FiDictionary new.	
	dictionary := nestedDictionary resultOf: (nestedDictionary editAt: #A equal: nestedDictionary).

	self assertRoundTripEquals: dictionary.
]
