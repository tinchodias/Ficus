Class {
	#name : #FiBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'aShot',
		'anotherShot'
	],
	#category : #'Ficus-Tests-Builder'
}

{ #category : #tests }
FiBuilderTest >> testCached [

	aShot := 
		FiRecipe 
			title: 'fortyTwo  ^42'
			kind: #accessing.

	anotherShot := 
		FiRecipe 
			title: 'fortyTwo  ^42'
			kind: #accessing.
			
	self assert: aShot == anotherShot
]

{ #category : #tests }
FiBuilderTest >> testErrorWhenSettingAnExcludedVariable [

	self skip: 'Decided to optimize and remove this validation'.
	self flag: #todo.
	

	self 
		assert: (FiRecipe excludedInstanceVariableNamesForSteps includes: #cachedHash)
		description: 'This is an assumption of this test'.
	
	self 
		should: [ 
			FiRecipe builder
				cachedHash: 123; "<- this is invalid"
				new ]
		raise: Error.

]

{ #category : #tests }
FiBuilderTest >> testNotCached [

	aShot := 
		FiRecipe 
			title: 'fortyTwo  ^42'
			kind: #accessing.

	anotherShot := 
		FiRecipe 
			title: 'fortyTwo  ^42'
			kind: #testing.
			
	self deny: aShot == anotherShot
]

{ #category : #tests }
FiBuilderTest >> testSingleNew [

	aShot := 
		FiRecipe 
			title: 'fortyTwo  ^42'
			kind: #accessing.
			
	self assert: aShot class equals: FiRecipe.
	self assert: aShot kind equals: #accessing.
]
