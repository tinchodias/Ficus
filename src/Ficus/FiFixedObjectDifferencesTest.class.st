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
		assert: (result changeFrom: source) 
		equals: (source changeOfReplaceBy: result).

]

{ #category : #tests }
FiFixedObjectDifferencesTest >> testReplacement2 [

	| source result |
	result := 17.
	source := 42.

	self 
		assert: (result changeFrom: source) 
		equals: (source changeOfReplaceBy: result).

]

{ #category : #tests }
FiFixedObjectDifferencesTest >> testSubAddition [
	"Test difference with a sub edit."

	| edit inverseEdit source result change inverseChange |
	source := FiChef nickname: #A.

	edit := source 
		editAt: #admiredChefs
		do: [ :admiredChefs | admiredChefs editInclude: #X ].
	
	result := source resultOf: edit.
	change := source changeOf: edit.

	inverseEdit := result 
		editAt: #admiredChefs
		do: [ :admiredChefs | admiredChefs editExclude: #X ].
	inverseChange := result changeOf: inverseEdit.

	self assert: (result changeFrom: source) equals: change.
	self assert: (source changeFrom: result) equals: inverseChange.
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

	self assert: (result changeFrom: source) equals: (source changeOf: edit).
	self assert: (source changeFrom: result) equals: (result changeOf: inverseEdit).
]
