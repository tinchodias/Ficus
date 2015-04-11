Extension { #name : #YrRoundTripTest }

{ #category : #'*FicusMonticelloYrupe' }
YrRoundTripTest >> testFicusClass [

	self assertRoundTripEquals: (FiClass named: #A).
]

{ #category : #'*FicusMonticelloYrupe' }
YrRoundTripTest >> testFicusDictionary [

	| dictionary |
	dictionary := FiDictionary new.	
	dictionary := dictionary resultOf: (dictionary editAt: #A equal: 42).

	self assertRoundTripEquals: dictionary.
]

{ #category : #'*FicusMonticelloYrupe' }
YrRoundTripTest >> testNestedFicusDictionary [

	| nestedDictionary dictionary |
	nestedDictionary := FiDictionary new.	
	nestedDictionary := nestedDictionary resultOf: (nestedDictionary editAt: #B equal: 42).
	dictionary := FiDictionary new.	
	dictionary := nestedDictionary resultOf: (nestedDictionary editAt: #A equal: nestedDictionary).

	self assertRoundTripEquals: dictionary.
]
