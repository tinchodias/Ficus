"
A FiGitStoreTest is a test class for testing the behavior of FiGitStore
"
Class {
	#name : #EFiGitRepositoryTest,
	#superclass : #TestCase,
	#instVars : [
		'store'
	],
	#category : #'EpiceaFicus-Tests'
}

{ #category : #running }
EFiGitRepositoryTest >> newStore [

	| directory |
	directory := FileSystem workingDirectory / 'yrupe-test-pharo'.	
	EFiEpiceaInstaller ensurePharoGitRepositoryUpToDateAt: directory.
	
	^ EFiGitRepository new
		repositoryFileReference: directory;
		yourself
]

{ #category : #running }
EFiGitRepositoryTest >> setUp [

	super setUp.

	store := self newStore.
]

{ #category : #tests }
EFiGitRepositoryTest >> testAtClassMethodSpot [

	| nodes |
	nodes := store revisionsLogAtSpot: 
		(FiMethodSpot 
			selector: #extent:
			behaviorName: #AthensSurface
			isMetaSide: true
			packageName: 'Athens-Core').
			
	self assert: nodes size equals: 4.
]

{ #category : #tests }
EFiGitRepositoryTest >> testAtClassSpot [

	| nodes |
	nodes := store revisionsLogAtSpot: 
		(FiBehaviorSpot 
			name: #AthensShape
			isMetaSide: false 
			packageName: 'Athens-Core').
	
	self assert: nodes size equals: 4.
]

{ #category : #tests }
EFiGitRepositoryTest >> testAtInstanceMethodSpot [

	| nodes |
	nodes := store revisionsLogAtSpot: 
		(FiMethodSpot 
			selector: #clear:
			behaviorName: #AthensSurface
			isMetaSide: false
			packageName: 'Athens-Core').
	
	self assert: nodes size equals: 4.
]

{ #category : #tests }
EFiGitRepositoryTest >> testAtMetaclassSpot [

	| nodes |
	nodes := store revisionsLogAtSpot: 
		(FiBehaviorSpot 
			name: #AthensShape
			isMetaSide: true 
			packageName: 'Athens-Core').
	
	self assert: nodes size equals: 4.
]

{ #category : #tests }
EFiGitRepositoryTest >> testAtPackageSpot [

	| nodes |
	nodes := store revisionsLogAtSpot: (FiPackageSpot named: 'Athens-Core').
	
	self assert: nodes size equals: 18.
]
