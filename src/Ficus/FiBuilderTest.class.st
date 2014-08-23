Class {
	#name : #FiBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'aShot',
		'anotherShot'
	],
	#category : #'Ficus-Tests'
}

{ #category : #tests }
FiBuilderTest >> testCached [

	aShot := 
		FiMethod builder
			protocol: #accessing;
			sourceCode: 'fortyTwo  ^42';
			new.

	anotherShot := 
		FiMethod builder
			protocol: #accessing;
			sourceCode: 'fortyTwo  ^42';
			new.
			
	self assert: aShot == anotherShot
]

{ #category : #tests }
FiBuilderTest >> testErrorWhenSettingAnExcludedVariable [

	self 
		assert: (FiMethod excludedInstanceVariableNamesForSteps includes: #selector)
		description: 'This is an assumption of this test'.
	
	self 
		should: [ 
			FiMethod builder
				protocol: #accessing;
				sourceCode: 'fortyTwo  ^42';
				selector: #fortyTwo;
				new ]
		raise: Error.

]

{ #category : #tests }
FiBuilderTest >> testNotCached [

	aShot := 
		FiMethod builder
			protocol: #accessing;
			sourceCode: 'fortyTwo  ^42';
			new.

	anotherShot := 
		FiMethod builder
			protocol: #testing;
			sourceCode: 'fortyTwo  ^42';
			new.
			
	self deny: aShot == anotherShot
]

{ #category : #tests }
FiBuilderTest >> testSingleNew [

	aShot := 
		FiMethod builder
			protocol: #accessing;
			sourceCode: 'fortyTwo  ^42';
			new.
			
	self assert: aShot class equals: FiMethod.
	self assert: aShot protocol equals: #accessing.
]
