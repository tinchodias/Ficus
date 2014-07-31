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
			selector: #fortyTwo;
			new.

	anotherShot := 
		FiMethod builder
			protocol: #accessing;
			sourceCode: 'fortyTwo  ^42';
			selector: #fortyTwo;
			new.
			
	self assert: aShot == anotherShot
]

{ #category : #tests }
FiBuilderTest >> testNotCached [

	aShot := 
		FiMethod builder
			protocol: #accessing;
			sourceCode: 'fortyTwo  ^42';
			selector: #fortyTwo;
			new.

	anotherShot := 
		FiMethod builder
			protocol: #testing;
			sourceCode: 'fortyTwo  ^42';
			selector: #fortyTwo;
			new.
			
	self deny: aShot == anotherShot
]

{ #category : #tests }
FiBuilderTest >> testSingleNew [

	aShot := 
		FiMethod builder
			protocol: #accessing;
			sourceCode: 'fortyTwo  ^42';
			selector: #fortyTwo;
			new.
			
	self assert: aShot class equals: FiMethod.
	self assert: aShot protocol equals: #accessing.
]
