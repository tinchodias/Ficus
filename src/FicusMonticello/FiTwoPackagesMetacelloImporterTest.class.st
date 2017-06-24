Class {
	#name : #FiTwoPackagesMetacelloImporterTest,
	#superclass : #FiMetacelloEnvironmentImporterTest,
	#category : #'FicusMonticello-Tests'
}

{ #category : #'as yet unclassified' }
FiTwoPackagesMetacelloImporterTest >> import [

	^ self importVersion: (ConfigurationOfTwoPackages project version: '1.0').
]

{ #category : #tests }
FiTwoPackagesMetacelloImporterTest >> testEnvironmentHasLoadedClass [

	| result |
	result := self import.
	
	"From one package"
	self assert: (result includesClassNamed: #RBMethodNode).

	"From the other package"
	self assert: (result includesClassNamed: #RBProgramNodeTest).
]

{ #category : #tests }
FiTwoPackagesMetacelloImporterTest >> testLoadedClassesHaveExtensionMethods [

	| result |
	result := self import.

	"the data of the extension method is there"
	self assert: ((result ficusPackages asArray flatCollect: #extensionMethods) anySatisfy: [ :each | each hostName =  #Fraction and: [ each isMetaSide ] ]).
	
	"Ring ficus will normalize and give us only the closure"
	self assert: result extensionMethodsByBehaviorName isEmpty.
]

{ #category : #tests }
FiTwoPackagesMetacelloImporterTest >> testLoadedClassesHaveInstanceVariables [

	| result theImportedClass |
	result := self import.
	
	"From one package"
	theImportedClass := result classNamed: #RBMethodNode.
	self assertCollection: theImportedClass instVarNames hasSameElements: #(#scope #selector #keywordsPositions #body #source #arguments #pragmas #replacements #nodeReplacements #compilationContext).
	
	"From the other package"
	theImportedClass := result classNamed: #RBProgramNodeTest .
	self assertCollection: theImportedClass instVarNames hasSameElements: #(#node).
]

{ #category : #tests }
FiTwoPackagesMetacelloImporterTest >> testLoadedClassesHaveMethods [

	| result theImportedClass |
	result := self import.

	"from one package"
	theImportedClass := result classNamed: #RBMethodNode.
	
	self assert: (theImportedClass methodNamed: #addNode:) sourceCode equals: 'addNode: aNode
	^ body addNode: aNode'.
	
	"from the other package"
	theImportedClass := result classNamed: #RBProgramNodeTest.
	
	self assert: (theImportedClass methodNamed: #node) sourceCode equals: 'node
	^ node ifNil: [ node := RBProgramNode new ]'.
]

{ #category : #tests }
FiTwoPackagesMetacelloImporterTest >> testLoadedClassesHaveMethodsInMetaclass [

	| result theImportedClass |
	result := self import.

	"From one package"
	theImportedClass := result classNamed: #RBMethodNode.
	
	self assert: (theImportedClass theMetaClass methodNamed: #selector:body:) sourceCode equals: 'selector: aSymbol body: aSequenceNode 
	^self 
		selector: aSymbol
		arguments: #()
		body: aSequenceNode'.
	
	"From the other package"
	theImportedClass := result classNamed: #RBProgramNodeTest.
	
	self assert: (theImportedClass theMetaClass methodNamed: #packageNamesUnderTest) sourceCode equals: 'packageNamesUnderTest
	^ #(''AST-Core'')'.
]

{ #category : #tests }
FiTwoPackagesMetacelloImporterTest >> testLoadedClassesHaveSuperclassName [

	| result theImportedClass |
	result := self import.

	"from one package"
	theImportedClass := result classNamed: #RBMethodNode.
	self assert: theImportedClass superclass name equals: #RBProgramNode.
	
	"Classes not in the environment should raise error"
	theImportedClass := result classNamed: #RBProgramNodeTest.
	self should: [theImportedClass superclass name = #TestCase ] raise: Error
]

{ #category : #tests }
FiTwoPackagesMetacelloImporterTest >> testNotEmptyEnviroment [

	| result |
	result := self import.
	self deny: result isEmpty.
]
