Class {
	#name : #FiOnePackageMetacelloImporterTest,
	#superclass : #FiMetacelloEnvironmentImporterTest,
	#category : #'FicusMonticello-Tests'
}

{ #category : #'as yet unclassified' }
FiOnePackageMetacelloImporterTest >> import [

	^ self importVersion: (ConfigurationOfOnePackage project version: '1.0').
]

{ #category : #tests }
FiOnePackageMetacelloImporterTest >> testEnvironmentHasLoadedClass [

	| result |
	result := self import.
	self assert: (result includesClassNamed: #RBMethodNode).
]

{ #category : #tests }
FiOnePackageMetacelloImporterTest >> testLoadedClassesHaveExtensionMethods [

	| result |
	result := self import.

	"the data of the extension method is there"
	self assert: (result ficusPackages anyOne extensionMethods anySatisfy: [ :each | each hostName =  #Fraction and: [ each isMetaSide ] ]).
	
	"Ring ficus will normalize and give us only the closure"
	self assert: result extensionMethodsByBehaviorName isEmpty.
]

{ #category : #tests }
FiOnePackageMetacelloImporterTest >> testLoadedClassesHaveInstanceVariables [

	| result theImportedClass |
	result := self import.
	theImportedClass := result classNamed: #RBMethodNode.
	self assertCollection: theImportedClass instVarNames hasSameElements: #(#scope #selector #keywordsPositions #body #source #arguments #pragmas #replacements #nodeReplacements #compilationContext).
]

{ #category : #tests }
FiOnePackageMetacelloImporterTest >> testLoadedClassesHaveMethods [

	| result theImportedClass |
	result := self import.

	theImportedClass := result classNamed: #RBMethodNode.
	
	self assert: (theImportedClass methodNamed: #addNode:) sourceCode equals: 'addNode: aNode
	^ body addNode: aNode'.
]

{ #category : #tests }
FiOnePackageMetacelloImporterTest >> testLoadedClassesHaveMethodsInMetaclass [

	| result theImportedClass |
	result := self import.

	theImportedClass := result classNamed: #RBMethodNode.
	
	self assert: (theImportedClass theMetaClass methodNamed: #selector:body:) sourceCode equals: 'selector: aSymbol body: aSequenceNode 
	^self 
		selector: aSymbol
		arguments: #()
		body: aSequenceNode'.
]

{ #category : #tests }
FiOnePackageMetacelloImporterTest >> testLoadedClassesHaveSuperclassName [

	| result theImportedClass |
	result := self import.

	theImportedClass := result classNamed: #RBMethodNode.
	self assert: theImportedClass superclass name equals: #RBProgramNode.
]

{ #category : #tests }
FiOnePackageMetacelloImporterTest >> testNotEmptyEnviroment [

	| result |
	result := self import.
	self deny: result isEmpty.
]
