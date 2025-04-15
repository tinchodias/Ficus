Class {
	#name : 'FiFixedObjectEditsTest',
	#superclass : 'TestCase',
	#category : 'Ficus2-Updates-Tests',
	#package : 'Ficus2-Updates-Tests'
}

{ #category : 'tests' }
FiFixedObjectEditsTest >> testSubAddition [

	| edit source result |
	source := FiChef nickname: #A.

	edit := 
		source 
			editAt: #admiredChefs
			do: [ :admiredChefs | admiredChefs editInclude: #X ].
	result := source resultOf: edit.

	self assert: source admiredChefs isEmpty.
	self assert: result admiredChefs asArray equals: { #X }.

]

{ #category : 'tests' }
FiFixedObjectEditsTest >> testSubAddition2 [

	| edit source item result |
	source := FiChef nickname: #A.
	item := FiRecipe title: 'fortyTwo ^42' kind: 'accessing'. 

	edit := 
		source 
			editAt: #recipes
			do: [ :spells | spells editInclude: item ].
	result := source resultOf: edit.

	self assert: source recipes values isEmpty.
	self assert: result recipes values asSet equals: { item } asSet.
	self assert: result recipes stepsAndValues asSet equals: { item title -> item } asSet.
]

{ #category : 'tests' }
FiFixedObjectEditsTest >> testSubAdditionAndUpdate [

	| edit source result |
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

	self assert: source admiredChefs isEmpty.
	self assert: source shortBio isEmpty.
	self assert: result admiredChefs asArray equals: { #X }.
	self assert: result shortBio equals: '42'.

]

{ #category : 'tests' }
FiFixedObjectEditsTest >> testSubRemoval [

	| edit preSource source result |
	preSource := FiChef nickname: #A.

	edit := 
		preSource 
			editAt: #admiredChefs
			do: [ :admiredChefs | admiredChefs editInclude: #X ].
	source := preSource resultOf: edit.

	edit := 
		source 
			editAt: #admiredChefs
			do: [ :admiredChefs | admiredChefs editExclude: #X ].
	result := source resultOf: edit.

	self assert: source admiredChefs asArray equals: { #X }.
	self assert: result admiredChefs isEmpty.

]

{ #category : 'tests' }
FiFixedObjectEditsTest >> testUpdate [

	| edit source result |
	source := FiChef nickname: #A.

	edit :=  source editAt: #shortBio equal: '42'.
	result := source resultOf: edit.
	
	self assert: source shortBio isEmpty.
	self assert: result shortBio equals: '42'.

]
