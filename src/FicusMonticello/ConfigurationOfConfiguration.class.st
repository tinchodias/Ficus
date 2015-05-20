Class {
	#name : #ConfigurationOfConfiguration,
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
ConfigurationOfConfiguration class >> DevelopmentSupport [
	<apiDocumentation>
	^ self
]

{ #category : #private }
ConfigurationOfConfiguration class >> baseConfigurationClassIfAbsent: t1 [
	^ Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: t1 ]
]

{ #category : #private }
ConfigurationOfConfiguration class >> ensureMetacello [
	(self baseConfigurationClassIfAbsent: [ nil ]) ensureMetacello.
	^ self
]

{ #category : #private }
ConfigurationOfConfiguration class >> ensureMetacelloBaseConfiguration [
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
ConfigurationOfConfiguration class >> isMetacelloConfig [
	^ true
]

{ #category : #loading }
ConfigurationOfConfiguration class >> load [
	<apiDocumentation>
	^ (self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfConfiguration class >> loadBleedingEdge [
	<apiDocumentation>
	^ (self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfConfiguration class >> loadDevelopment [
	<apiDocumentation>
	^ (self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfConfiguration class >> project [
	^ self new project
]

{ #category : #'development support' }
ConfigurationOfConfiguration class >> validate [
	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfConfiguration >> baseline10: spec [
	<version: '1.0-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec description: 'first shot'.
			spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Pharo40/main'.
			spec project: 'SubProject' with: [ 
				spec 
					className: 'ConfigurationOfTwoPackages';
					file: self class package name;
					version: '1.0';
					repository: 'http://www.smalltalkhub.com/mc/Guille/playground/main' ] ].
]

{ #category : #accessing }
ConfigurationOfConfiguration >> customProjectAttributes [
	^ #()
]

{ #category : #accessing }
ConfigurationOfConfiguration >> project [
	^ project
		ifNil: [ 
			(self class baseConfigurationClassIfAbsent: [ nil ]) ensureMetacello.
			project := MetacelloMCProject new projectAttributes: self customProjectAttributes.
			(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
			project loadType: #linear.
			project ]
]

{ #category : #versions }
ConfigurationOfConfiguration >> version100: spec [
	<version: '1.0' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #stable.
			spec description: 'version 1.0.0'.
			spec project: 'SubProject' with: '1.0' ].
]
