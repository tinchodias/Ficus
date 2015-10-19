Class {
	#name : #FiCargoImporterTest,
	#superclass : #TestCase,
	#category : #'FicusMonticello-Tests'
}

{ #category : #accessing }
FiCargoImporterTest class >> resources [
	^ { GoferResource }
]

{ #category : #importing }
FiCargoImporterTest >> import: aListOfMcVersions [

	^ FiCargoWriter new ficusEnvironmentFromMcVersions: aListOfMcVersions
]

{ #category : #tests }
FiCargoImporterTest >> testShouldEmptyMcVersionListGiveEmptyFicusEnvironment [
	| environment |
	environment := self import: #().
	
	self assert: environment isEmpty
]

{ #category : #'tests - 1 package' }
FiCargoImporterTest >> testShouldInstanceVariablesOfClassesBeLoadInResultingEnvironment [
	| environment theImportedClass |
	environment := self import: { FiMcVersionRessource current onePackageMcVersion }.
	theImportedClass := environment classNamed: #ANewClass.

	self 
		assertCollection: theImportedClass instVarNames 
		hasSameElements: #(a b c d).
]

{ #category : #'tests - 1 package' }
FiCargoImporterTest >> testShouldMcVersionGiveEnvironmentWithClasses [
	| environment |
	environment := self import: { FiMcVersionRessource current onePackageMcVersion }.
	
	self assert: (environment includesClassNamed: #ANewClass).
]

{ #category : #'tests - 1 package' }
FiCargoImporterTest >> testShouldMcVersionWithExtensionMethodOnAnExistingClassGiveValidEnvironment [
	| environment extensionMethods |
	environment := self import: { FiMcVersionRessource current onePackageMcVersion }.
	extensionMethods := environment ficusPackages anyOne extensionMethods.
	
	self 
		assert: extensionMethods size
		equals: 1.
	self 
		assert: extensionMethods anyOne hostName
		equals: #ANewClass.
	self deny: extensionMethods anyOne isMetaSide
]

{ #category : #'tests - 1 package' }
FiCargoImporterTest >> testShouldMcVersionWithMethodOnAnExistingClassGiveValidEnvironment [
	| environment theImportedClass |
	environment := self import: { FiMcVersionRessource current onePackageMcVersion }.
	theImportedClass := environment classNamed: #ANewClass.
	
	self 
		assert: (theImportedClass methodNamed: #version10MBFooTest:) sourceCode
		equals: 'version10MBFooTest: foo
	"NOP"'
]

{ #category : #'tests - 1 package' }
FiCargoImporterTest >> testShouldMcVersionWithMethodOnMetaClassGiveValidEnvironment [
	| environment theImportedClass |
	environment := self import: { FiMcVersionRessource current onePackageMcVersion }.
	theImportedClass := environment classNamed: #ANewClass.
	
	self 
		assert: (theImportedClass theMetaClass methodNamed: #isMetacelloConfig) sourceCode
		equals: 'isMetacelloConfig'
]

{ #category : #'tests - 1 package' }
FiCargoImporterTest >> testShouldMcVersionwithAClassDefinitionPreserveSuperClass [
	| environment theImportedClass |
	environment := self import: { FiMcVersionRessource current onePackageMcVersion }.
	theImportedClass := environment classNamed: #ANewClass.
	
	self 
		assert: theImportedClass superclass name
		equals: #Object
]

{ #category : #'tests - 1 package' }
FiCargoImporterTest >> testShouldntMcVersionGiveEmptyFicusEnvironment [
	| environment |
	environment := self import: { FiMcVersionRessource current onePackageMcVersion }.
	
	self deny: environment isEmpty
]
