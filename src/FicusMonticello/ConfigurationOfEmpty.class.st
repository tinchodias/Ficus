Class {
	#name : #ConfigurationOfEmpty,
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
ConfigurationOfEmpty class >> DevelopmentSupport [
	<apiDocumentation>
	^ self
]

{ #category : #private }
ConfigurationOfEmpty class >> baseConfigurationClassIfAbsent: t1 [
	^ Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: t1 ]
]

{ #category : #private }
ConfigurationOfEmpty class >> ensureMetacello [
	(self baseConfigurationClassIfAbsent: [ nil ]) ensureMetacello.
	^ self
]

{ #category : #private }
ConfigurationOfEmpty class >> ensureMetacelloBaseConfiguration [
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
ConfigurationOfEmpty class >> isMetacelloConfig [
	^ true
]

{ #category : #loading }
ConfigurationOfEmpty class >> load [
	<apiDocumentation>
	^ (self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfEmpty class >> loadBleedingEdge [
	<apiDocumentation>
	^ (self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfEmpty class >> loadDevelopment [
	<apiDocumentation>
	^ (self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfEmpty class >> project [
	^ self new project
]

{ #category : #'development support' }
ConfigurationOfEmpty class >> validate [
	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfEmpty >> baseline10: t1 [
	<version: '1.0-baseline'>
	t1
		for: #common
		do: [ 
			t1 blessing: #baseline.
			t1 description: 'first shot' ].
]

{ #category : #accessing }
ConfigurationOfEmpty >> customProjectAttributes [
	^ #()
]

{ #category : #accessing }
ConfigurationOfEmpty >> project [
	^ project
		ifNil: [ 
			(self class baseConfigurationClassIfAbsent: [ nil ]) ensureMetacello.
			project := MetacelloMCProject new projectAttributes: self customProjectAttributes.
			(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
			project loadType: #linear.
			project ]
]

{ #category : #versions }
ConfigurationOfEmpty >> version100: t1 [
	<version: '1.0' imports: #('1.0-baseline')>
	t1
		for: #common
		do: [ 
			t1 blessing: #stable.
			t1 description: 'version 1.0.0'. ].
]
