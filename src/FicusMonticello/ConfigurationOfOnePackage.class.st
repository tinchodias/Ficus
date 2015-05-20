Class {
	#name : #ConfigurationOfOnePackage,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #'FicusMonticello-Tests'
}

{ #category : #'development support' }
ConfigurationOfOnePackage class >> DevelopmentSupport [
	<apiDocumentation>
	^ self
]

{ #category : #private }
ConfigurationOfOnePackage class >> baseConfigurationClassIfAbsent: t1 [
	^ Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: t1 ]
]

{ #category : #private }
ConfigurationOfOnePackage class >> ensureMetacello [
	(self baseConfigurationClassIfAbsent: [ nil ]) ensureMetacello.
	^ self
]

{ #category : #private }
ConfigurationOfOnePackage class >> ensureMetacelloBaseConfiguration [
	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| t1 t2 |
			t2 := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			t2
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :t4 | 
					t1 := t4 version.
					t1 load.
					t1 workingCopy repositoryGroup addRepository: t2 ] ].
	^ self
]

{ #category : #'metacello tool support' }
ConfigurationOfOnePackage class >> isMetacelloConfig [
	^ true
]

{ #category : #loading }
ConfigurationOfOnePackage class >> load [
	<apiDocumentation>
	^ (self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfOnePackage class >> loadBleedingEdge [
	<apiDocumentation>
	^ (self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfOnePackage class >> loadDevelopment [
	<apiDocumentation>
	^ (self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfOnePackage class >> project [
	^ self new project
]

{ #category : #'development support' }
ConfigurationOfOnePackage class >> validate [
	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfOnePackage >> baseline10: spec [
	<version: '1.0-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec description: 'first shot'.
			spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Pharo40/main'.
			spec package: 'AST-Core' ].
]

{ #category : #accessing }
ConfigurationOfOnePackage >> customProjectAttributes [
	^ #()
]

{ #category : #accessing }
ConfigurationOfOnePackage >> project [
	^ project
		ifNil: [ 
			(self class baseConfigurationClassIfAbsent: [ nil ]) ensureMetacello.
			project := MetacelloMCProject new projectAttributes: self customProjectAttributes.
			(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
			project loadType: #linear.
			project ]
]

{ #category : #versions }
ConfigurationOfOnePackage >> version100: spec [
	<version: '1.0' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #stable.
			spec description: 'version 1.0.0'.
			spec package: 'AST-Core' with: 'AST-Core-TheIntegrator.283'. ].
]
