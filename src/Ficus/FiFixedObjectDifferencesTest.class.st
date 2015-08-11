Class {
	#name : #FiFixedObjectDifferencesTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiFixedObjectDifferencesTest >> testReplacement [

	| source result |
	result := FiChef nickname: #A.
	source := 42.

	self 
		assert: (result differenceFrom: source) 
		equals: (source effectOfReplaceBy: result).

]

{ #category : #tests }
FiFixedObjectDifferencesTest >> testReplacement2 [

	| source result |
	result := 17.
	source := 42.

	self 
		assert: (result differenceFrom: source) 
		equals: (source effectOfReplaceBy: result).

]

{ #category : #tests }
FiFixedObjectDifferencesTest >> testSubAddition [
	"Test difference with a sub edit."

	| edit inverseEdit source result effect inverseEffect |
	source := FiChef nickname: #A.

	edit := source 
		editAt: #admiredChefs
		do: [ :admiredChefs | admiredChefs editInclude: #X ].
	
	result := source resultOf: edit.
	effect := source effectOf: edit.

	inverseEdit := result 
		editAt: #admiredChefs
		do: [ :admiredChefs | admiredChefs editExclude: #X ].
	inverseEffect := result effectOf: inverseEdit.

	self assert: (result differenceFrom: source) equals: effect.
	self assert: (source differenceFrom: result) equals: inverseEffect.
]

{ #category : #tests }
FiFixedObjectDifferencesTest >> testUpdateAndSubAddition [

	| edit inverseEdit source result |
	source := FiChef nickname: #A.

	edit := source editAll: {
		source 
			editAt: #admiredChefs
			do: [ :admiredChefs | admiredChefs editInclude: #X ].
		source
			editAt: #shortBio
			equal: '42'.
		}.
			
	result := source resultOf: edit.

	inverseEdit := result editAll: {
		result 
			editAt: #admiredChefs
			do: [ :admiredChefs | admiredChefs editExclude: #X ].
		result 
			editAt: #shortBio
			equal: ''.
		}.

	self assert: (result differenceFrom: source) equals: (source effectOf: edit).
	self assert: (source differenceFrom: result) equals: (result effectOf: inverseEdit).
]
