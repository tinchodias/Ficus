"
I'm a resource providing Monticello versions for tests purposes
"
Class {
	#name : #FiMcVersionRessource,
	#superclass : #TestResource,
	#category : #'FicusMonticello-Tests'
}

{ #category : #utility }
FiMcVersionRessource >> mcVersionFor: aPackageName from: aListOfDefinitions [
	^ MCVersion
		package: aPackageName
		info: (MCVersionInfo
			name: aPackageName
			id: UUID new
			message: 'This is a mock version'
			date: Date today
			time: Time now
			author: 'dummy version for tests purposes.'
			ancestors: #())
		snapshot: (MCSnapshot fromDefinitions: aListOfDefinitions)
]

{ #category : #definitions }
FiMcVersionRessource >> onePackageDefinitions [
	| className |
	className := #ANewClass.
	^ {
					MCOrganizationDefinition categories: (Array with: #NewPackage).
					MCClassDefinition name: #Object superclassName: #ProtoObject category: className instVarNames: #() comment: ''.
					MCClassDefinition name: className superclassName: #Object category: className instVarNames: #(b c d a) comment: ''.
					MCMethodDefinition 
						className: className asString
						classIsMeta: true
						selector: 'isMetacelloConfig'
						category: 'cat'
						timeStamp: ''
						source: 'isMetacelloConfig'.
					MCMethodDefinition 
						className: className asString
						classIsMeta: true
						selector: 'project'
						category: 'cat'
						timeStamp: ''
						source: 'project'.
					MCMethodDefinition 
						className: className asString
						selector: 'version10MBFooTest:'
						category: 'cat'
						timeStamp: ''
						source: 'version10MBFooTest: foo
	"NOP"'.
					MCMethodDefinition 
						className: className asString
						selector: 'extensionMethod'
						category: '*FooPackage'
						timeStamp: ''
						source: 'extensionMethod
	^ self' 
				}
]

{ #category : #'mc versions' }
FiMcVersionRessource >> onePackageMcVersion [
	^ self
		mcVersionFor: 'Foo' 
		from: self onePackageDefinitions 
]
