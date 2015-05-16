Extension { #name : #FiPathTest }

{ #category : #'*FicusExtras' }
FiPathTest >> testFlattened [

	| aSet aShot |
	aShot := FiRecipe title: 'fortyTwo' kind: #accessing.
	aSet := { aShot } asFiSet.

	self 
		assert: aSet flattened 
		equals: { 
			FiPath root -> aSet.
			FiPath root / #fortyTwo -> aShot.
			FiPath root / #fortyTwo / #title -> 'fortyTwo'.
			FiPath root / #fortyTwo / #kind -> #accessing.
			}.
]
