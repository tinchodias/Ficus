Class {
	#name : #FiShotTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-Edits'
}

{ #category : #tests }
FiShotTest >> testSubAddition [

	| edit source result |
	source := FiChef nickname: #A.

	edit := 
		source 
			at: #admiredChefs
			edit: [ :admiredChefs | admiredChefs include: #X ].
	result := source resultOf: edit.

	self assert: source admiredChefs isEmpty.
	self assert: result admiredChefs asArray equals: { #X }.

]

{ #category : #tests }
FiShotTest >> testSubAddition2 [

	| edit source item result |
	source := FiChef nickname: #A.
	item := FiRecipe title: 'fortyTwo ^42' kind: 'accessing'. 

	edit := 
		source 
			at: #recipes
			edit: [ :spells | spells include: item ].
	result := source resultOf: edit.

	self assert: source recipes values isEmpty.
	self assert: result recipes values asSet equals: { item } asSet.
	self assert: result recipes stepsAndValues asSet equals: { item title -> item } asSet.
]

{ #category : #tests }
FiShotTest >> testSubAdditionAndUpdate [

	| edit source result |
	source := FiChef nickname: #A.

	edit := source edits: {
		source 
			at: #admiredChefs
			edit: [ :admiredChefs | admiredChefs include: #X ].
		source
			at: #shortBio
			equal: '42'.
		}.
			
	result := source resultOf: edit.

	self assert: source admiredChefs isEmpty.
	self assert: source shortBio isEmpty.
	self assert: result admiredChefs asArray equals: { #X }.
	self assert: result shortBio equals: '42'.

]

{ #category : #tests }
FiShotTest >> testSubRemoval [

	| edit preSource source result |
	preSource := FiChef nickname: #A.

	edit := 
		preSource 
			at: #admiredChefs
			edit: [ :admiredChefs | admiredChefs include: #X ].
	source := preSource resultOf: edit.

	edit := 
		source 
			at: #admiredChefs
			edit: [ :admiredChefs | admiredChefs exclude: #X ].
	result := source resultOf: edit.

	self assert: source admiredChefs asArray equals: { #X }.
	self assert: result admiredChefs isEmpty.

]

{ #category : #tests }
FiShotTest >> testUpdate [

	| edit source result |
	source := FiChef nickname: #A.

	edit :=  source at: #shortBio equal: '42'.
	result := source resultOf: edit.
	
	self assert: source shortBio isEmpty.
	self assert: result shortBio equals: '42'.

]
