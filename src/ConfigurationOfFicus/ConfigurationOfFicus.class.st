Class {
	#name : #ConfigurationOfFicus,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfFicus
}

{ #category : #'development support' }
ConfigurationOfFicus class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfFicus class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfFicus class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfFicus class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfFicus class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfFicus class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfFicus class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfFicus class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfFicus class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfFicus class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfFicus >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/MartinDias/Ficus/main/'.
		spec project: #Epicea with: [
			spec
				className: #ConfigurationOfEpicea;
				versionString: #'bleedingEdge';
				repository: 'http://smalltalkhub.com/mc/MartinDias/Epicea/main/' ].
		spec project: #Yrupe with: [
			spec
				className: #ConfigurationOfYrupe;
				versionString: #'bleedingEdge';
				repository: 'http://smalltalkhub.com/mc/MartinDias/Yrupe/main/' ].
		spec
			package: #Hiedra with: [ 
				spec repository: 'http://smalltalkhub.com/mc/MartinDias/Epicea/main/' ];
			package: #Ficus;
			package: #FicusExtras with: [
				spec requires: #(#Ficus) ];
			package: #FicusMetamodel with: [
				spec requires: #(#Ficus) ];
			package: #FicusRing with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusImpact with: [
				spec requires: #(#FicusRing #FicusStore) ];
			package: #FicusStore with: [
				spec requires: #(#FicusMetamodel #Hiedra) ];
			package: #FicusMonticello with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusMonticelloStore with: [
				spec requires: #(#FicusMonticello #FicusStore) ];
			package: #FicusMonticelloYrupe with: [
				spec requires: #(#FicusMonticello #Yrupe #FicusExtras) ]; "FicusExtras: only because of FiDictionary, which is used in tests."
			package: #FicusEpicea with: [
				spec requires: #(#FicusMetamodel #FicusMonticelloStore #Epicea) ].
		spec
			group: 'default' with: #('Ficus' 'FicusEpicea' 'FicusStore' 'FicusImpact' 'FicusMonticelloYrupe');
			group: 'mini' with: #('FicusRing' 'FicusMonticello') ].

]

{ #category : #baselines }
ConfigurationOfFicus >> baseline036: spec [
	<version: '0.3.6-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/MartinDias/Ficus/main/'.
		spec project: #Yrupe with: [
			spec
				className: #ConfigurationOfYrupe;
				versionString: #'bleedingEdge';
				repository: 'http://smalltalkhub.com/mc/MartinDias/Yrupe/main/' ].
		spec project: #PharoVersionsMiner with: [
			spec
				className: #ConfigurationOfPharoMiner;
				versionString: #'bleedingEdge';
				repository: 'http://smalltalkhub.com/mc/MartinDias/PharoMiner/main/';
				loads: #(core) ].
		spec
			package: #Hiedra with: [ 
				spec repository: 'http://smalltalkhub.com/mc/MartinDias/Epicea/main/' ];
			package: #Ficus;
			package: #FicusExtras with: [
				spec requires: #(#Ficus) ];
			package: #FicusMetamodel with: [
				spec requires: #(#Ficus) ];
			package: #FicusRing with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusImpact with: [
				spec requires: #(#FicusRing #FicusStore) ];
			package: #FicusStore with: [
				spec requires: #(#FicusMetamodel #Hiedra) ];
			package: #FicusMonticello with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusMonticelloStore with: [
				spec requires: #(#FicusMonticello #FicusStore) ];
			package: #FicusMonticelloYrupe with: [
				spec requires: #(#FicusMonticello #Yrupe #FicusExtras #PharoVersionsMiner) ]; 
					"FicusExtras: only because of FiDictionary, which is used in tests."
			package: #FicusEpicea with: [
				spec requires: #(#FicusMetamodel #FicusMonticelloStore) ].
		spec
			group: 'default' with: #('Ficus' 'FicusEpicea' 'FicusStore' 'FicusImpact' 'FicusMonticelloYrupe');
			group: 'mini' with: #('FicusRing' 'FicusMonticello') ].

]

{ #category : #baselines }
ConfigurationOfFicus >> baseline03: spec [
	<version: '0.3-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/MartinDias/Ficus/main/'.
		spec project: #Epicea with: [
			spec
				className: #ConfigurationOfEpicea;
				versionString: #'bleedingEdge';
				repository: 'http://smalltalkhub.com/mc/MartinDias/Epicea/main/' ].
		spec project: #Yrupe with: [
			spec
				className: #ConfigurationOfYrupe;
				versionString: #'bleedingEdge';
				repository: 'http://smalltalkhub.com/mc/MartinDias/Yrupe/main/' ].
		spec project: #PharoVersionsMiner with: [
			spec
				className: #ConfigurationOfPharoMiner;
				versionString: #'bleedingEdge';
				repository: 'http://smalltalkhub.com/mc/MartinDias/PharoMiner/main/';
				loads: #(core) ].
		spec
			package: #Hiedra with: [ 
				spec repository: 'http://smalltalkhub.com/mc/MartinDias/Epicea/main/' ];
			package: #Ficus;
			package: #FicusExtras with: [
				spec requires: #(#Ficus) ];
			package: #FicusMetamodel with: [
				spec requires: #(#Ficus) ];
			package: #FicusRing with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusImpact with: [
				spec requires: #(#FicusRing #FicusStore) ];
			package: #FicusStore with: [
				spec requires: #(#FicusMetamodel #Hiedra) ];
			package: #FicusMonticello with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusMonticelloStore with: [
				spec requires: #(#FicusMonticello #FicusStore) ];
			package: #FicusMonticelloYrupe with: [
				spec requires: #(#FicusMonticello #Yrupe #FicusExtras #PharoVersionsMiner) ]; 
					"FicusExtras: only because of FiDictionary, which is used in tests."
			package: #FicusEpicea with: [
				spec requires: #(#FicusMetamodel #FicusMonticelloStore #Epicea) ].
		spec
			group: 'default' with: #('Ficus' 'FicusEpicea' 'FicusStore' 'FicusImpact' 'FicusMonticelloYrupe');
			group: 'mini' with: #('FicusRing' 'FicusMonticello') ].

]

{ #category : #baselines }
ConfigurationOfFicus >> baseline04: spec [
	<version: '0.4-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/MartinDias/Ficus/main/'.
		spec project: #Epicea with: [
			spec
				className: #ConfigurationOfEpicea;
				versionString: #development;
				repository: 'http://smalltalkhub.com/mc/MartinDias/Epicea/main/' ].
		spec project: #Yrupe with: [
			spec
				className: #ConfigurationOfYrupe;
				versionString: #development;
				repository: 'http://smalltalkhub.com/mc/MartinDias/Yrupe/main/' ].
		spec project: #PharoVersionsMiner with: [
			spec
				className: #ConfigurationOfPharoMiner;
				versionString: #development;
				repository: 'http://smalltalkhub.com/mc/MartinDias/PharoMiner/main/';
				loads: #(core) ].
		spec
			package: #Hiedra with: [ 
				spec repository: 'http://smalltalkhub.com/mc/MartinDias/Epicea/main/' ];
			package: #Ficus;
			package: #FicusExtras with: [
				spec requires: #(#Ficus) ];
			package: #FicusMetamodel with: [
				spec requires: #(#Ficus) ];
			package: #FicusRing with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusImpact with: [
				spec requires: #(#FicusRing #FicusStore) ];
			package: #FicusStore with: [
				spec requires: #(#FicusMetamodel #Hiedra) ];
			package: #FicusMonticello with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusMonticelloStore with: [
				spec requires: #(#FicusMonticello #FicusStore) ];
			package: #FicusMonticelloYrupe with: [
				spec requires: #(#FicusMonticello #Yrupe #FicusExtras #PharoVersionsMiner) ]; 
					"FicusExtras: only because of FiDictionary, which is used in tests."
			package: #FicusEpicea with: [
				spec requires: #(#FicusMetamodel #FicusMonticelloStore #Epicea) ].
		spec
			group: 'default' with: #('Ficus' 'FicusEpicea' 'FicusStore' 'FicusImpact' 'FicusMonticelloYrupe');
			group: 'mini' with: #('FicusRing' 'FicusMonticello') ].

]

{ #category : #accessing }
ConfigurationOfFicus >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfFicus >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.4-baseline'.

]

{ #category : #accessing }
ConfigurationOfFicus >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfFicus >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.6'.

]

{ #category : #versions }
ConfigurationOfFicus >> version01: spec [
	<version: '0.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.1'.
		spec author: 'MartinDias'.
		spec timestamp: '5/20/2015 12:14'.
		spec 
			project: #Epicea with: '4.8-baseline';
			project: #Yrupe with: '0.1-baseline'.
		spec 
			package: #Hiedra with: #Hiedra;
			package: #Ficus with: 'Ficus-MartinDias.181';
			package: #FicusExtras with: #FicusExtras;
			package: #FicusMetamodel with: 'FicusMetamodel-MartinDias.14';
			package: #FicusRing with: 'FicusRing-MartinDias.116';
			package: #FicusImpact with: #FicusImpact;
			package: #FicusStore with: #FicusStore;
			package: #FicusMonticello with: 'FicusMonticello-MartinDias.61';
			package: #FicusMonticelloStore with: #FicusMonticelloStore;
			package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
			package: #FicusEpicea with: #FicusEpicea. ].

]

{ #category : #versions }
ConfigurationOfFicus >> version02: spec [
	<version: '0.2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.
		Added metacello writer and tests'.
		spec author: 'GuillermoPolito'.
		spec timestamp: '5/20/2015 14:24'.
		spec 
			project: #Epicea with: '4.8-baseline';
			project: #Yrupe with: '0.1-baseline'.
		spec 
			package: #Hiedra with: #Hiedra;
			package: #Ficus with: 'Ficus-GuillermoPolito.182';
			package: #FicusExtras with: #FicusExtras;
			package: #FicusMetamodel with: 'FicusMetamodel-MartinDias.14';
			package: #FicusRing with: 'FicusRing-GuillermoPolito.117';
			package: #FicusImpact with: #FicusImpact;
			package: #FicusStore with: #FicusStore;
			package: #FicusMonticello with: 'FicusMonticello-GuillermoPolito.62';
			package: #FicusMonticelloStore with: #FicusMonticelloStore;
			package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
			package: #FicusEpicea with: #FicusEpicea. ].

]

{ #category : #versions }
ConfigurationOfFicus >> version031: spec [
	<version: '0.3.1' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.3.1'.
		spec author: 'GuillermoPolito'.
		spec timestamp: '6/3/2015 15:42'.
		spec 
			project: #Epicea with: '4.8-baseline';
			project: #Yrupe with: '0.1-baseline';
			project: #PharoVersionsMiner with: '0.1-baseline'.
		spec 
			package: #Hiedra with: #Hiedra;
			package: #Ficus with: 'Ficus-GuillermoPolito.185';
			package: #FicusExtras with: #FicusExtras;
			package: #FicusMetamodel with: 'FicusMetamodel-GuillermoPolito.18';
			package: #FicusRing with: 'FicusRing-GuillermoPolito.124';
			package: #FicusImpact with: #FicusImpact;
			package: #FicusStore with: #FicusStore;
			package: #FicusMonticello with: 'FicusMonticello-GuillermoPolito.65';
			package: #FicusMonticelloStore with: #FicusMonticelloStore;
			package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
			package: #FicusEpicea with: #FicusEpicea. ].

]

{ #category : #versions }
ConfigurationOfFicus >> version032: spec [
	<version: '0.3.2' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.3.2'.
		spec author: 'GuillermoPolito'.
		spec timestamp: '2016-06-06T10:00:53.156563+02:00'.
		spec 
			project: #Epicea with: '4.8-baseline';
			project: #Yrupe with: '0.1-baseline';
			project: #PharoVersionsMiner with: '0.1-baseline'.
		spec 
			package: #Hiedra with: #Hiedra;
			package: #Ficus with: 'Ficus-GuillermoPolito.185';
			package: #FicusExtras with: #FicusExtras;
			package: #FicusMetamodel with: 'FicusMetamodel-GuillermoPolito.18';
			package: #FicusRing with: 'FicusRing-GuillermoPolito.125';
			package: #FicusImpact with: #FicusImpact;
			package: #FicusStore with: #FicusStore;
			package: #FicusMonticello with: 'FicusMonticello-GuillermoPolito.65';
			package: #FicusMonticelloStore with: #FicusMonticelloStore;
			package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
			package: #FicusEpicea with: #FicusEpicea. ].

]

{ #category : #versions }
ConfigurationOfFicus >> version033: spec [
	<version: '0.3.3' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.3.2 + ephemeron support'.
		spec author: 'GuillermoPolito'.
		spec timestamp: '2016-06-07T20:36:42.140672+02:00'.
		spec 
			project: #Epicea with: '4.8-baseline';
			project: #Yrupe with: '0.1-baseline';
			project: #PharoVersionsMiner with: '0.1-baseline'.
		spec 
			package: #Hiedra with: #Hiedra;
			package: #Ficus with: 'Ficus-GuillermoPolito.185';
			package: #FicusExtras with: #FicusExtras;
			package: #FicusMetamodel with: 'FicusMetamodel-GuillermoPolito.19';
			package: #FicusRing with: 'FicusRing-GuillermoPolito.126';
			package: #FicusImpact with: #FicusImpact;
			package: #FicusStore with: #FicusStore;
			package: #FicusMonticello with: 'FicusMonticello-GuillermoPolito.66';
			package: #FicusMonticelloStore with: #FicusMonticelloStore;
			package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
			package: #FicusEpicea with: #FicusEpicea. ].

]

{ #category : #versions }
ConfigurationOfFicus >> version034: spec [
	<version: '0.3.4' imports: #('0.3-baseline')>
	spec
		for: #common
		do: [ spec blessing: #stable.
			spec description: 'version 0.3.3 + Cargo writer'.
			spec author: 'ChristopheDemarey'.
			spec timestamp: '2016-07-07T15:18:42.140642+02:00'.
			spec
				project: #Epicea with: '4.8-baseline';
				project: #Yrupe with: '0.1-baseline';
				project: #PharoVersionsMiner with: '0.1-baseline'.
			spec
				package: #Hiedra with: #Hiedra;
				package: #Ficus with: 'Ficus-GuillermoPolito.185';
				package: #FicusExtras with: #FicusExtras;
				package: #FicusMetamodel with: 'FicusMetamodel-GuillermoPolito.19';
				package: #FicusRing with: 'FicusRing-GuillermoPolito.126';
				package: #FicusImpact with: #FicusImpact;
				package: #FicusStore with: #FicusStore;
				package: #FicusMonticello with: 'FicusMonticello-ChristopheDemarey.67';
				package: #FicusMonticelloStore with: #FicusMonticelloStore;
				package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
				package: #FicusEpicea with: #FicusEpicea ]
]

{ #category : #versions }
ConfigurationOfFicus >> version035: spec [
	<version: '0.3.5' imports: #('0.3-baseline')>
	spec
		for: #common
		do: [ spec blessing: #stable.
			spec description: 'version 0.3.5'.
			spec author: 'Guillermo Polito'.
			spec timestamp: '2016-12-08T14:46:35.710095+01:00'.
			spec
				project: #Epicea with: '4.8-baseline';
				project: #Yrupe with: '0.1-baseline';
				project: #PharoVersionsMiner with: '0.1-baseline'.
			spec
				package: #Hiedra with: #Hiedra;
				package: #Ficus with: 'Ficus-GuillermoPolito.185';
				package: #FicusExtras with: #FicusExtras;
				package: #FicusMetamodel with: 'FicusMetamodel-GuillermoPolito.19';
				package: #FicusRing with: 'FicusRing-GuillermoPolito.127';
				package: #FicusImpact with: #FicusImpact;
				package: #FicusStore with: #FicusStore;
				package: #FicusMonticello with: 'FicusMonticello-GuillermoPolito.68';
				package: #FicusMonticelloStore with: #FicusMonticelloStore;
				package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
				package: #FicusEpicea with: #FicusEpicea ]
]

{ #category : #versions }
ConfigurationOfFicus >> version036: spec [
	<version: '0.3.6' imports: #('0.3.6-baseline')>
	spec
		for: #common
		do: [ spec blessing: #stable.
			spec description: 'version 0.3.6'.
			spec author: 'Guillermo Polito'.
			spec timestamp: '2016-12-08T14:46:35.710095+01:00'.
			spec
				project: #Yrupe with: '0.1-baseline';
				project: #PharoVersionsMiner with: '0.1-baseline'.
			spec
				package: #Hiedra with: #Hiedra;
				package: #Ficus with: 'Ficus-GuillermoPolito.185';
				package: #FicusExtras with: #FicusExtras;
				package: #FicusMetamodel with: 'FicusMetamodel-GuillermoPolito.19';
				package: #FicusRing with: 'FicusRing-GuillermoPolito.127';
				package: #FicusImpact with: #FicusImpact;
				package: #FicusStore with: #FicusStore;
				package: #FicusMonticello with: 'FicusMonticello-GuillermoPolito.68';
				package: #FicusMonticelloStore with: #FicusMonticelloStore;
				package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
				package: #FicusEpicea with: #FicusEpicea ]
]

{ #category : #versions }
ConfigurationOfFicus >> version037: spec [
	<version: '0.3.7' imports: #('0.3.6-baseline')>
	spec
		for: #common
		do: [ spec blessing: #stable.
			spec description: 'version 0.3.7'.
			spec author: 'Guillermo Polito'.
			spec timestamp: '2017-07-25T15:22:00.000000+01:00'.
			spec
				project: #Yrupe with: '0.1-baseline';
				project: #PharoVersionsMiner with: '0.1-baseline'.
			spec
				package: #Hiedra with: #Hiedra;
				package: #Ficus with: 'Ficus-GuillermoPolito.185';
				package: #FicusExtras with: #FicusExtras;
				package: #FicusMetamodel with: 'FicusMetamodel-GuillermoPolito.19';
				package: #FicusRing with: 'FicusRing-GuillermoPolito.128';
				package: #FicusImpact with: #FicusImpact;
				package: #FicusStore with: #FicusStore;
				package: #FicusMonticello with: 'FicusMonticello-GuillermoPolito.68';
				package: #FicusMonticelloStore with: #FicusMonticelloStore;
				package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
				package: #FicusEpicea with: #FicusEpicea ]
]

{ #category : #versions }
ConfigurationOfFicus >> version03: spec [
	<version: '0.3' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.3'.
		spec author: 'GuillermoPolito'.
		spec timestamp: '6/3/2015 15:42'.
		spec 
			project: #Epicea with: '4.8-baseline';
			project: #Yrupe with: '0.1-baseline';
			project: #PharoVersionsMiner with: '0.1-baseline'.
		spec 
			package: #Hiedra with: #Hiedra;
			package: #Ficus with: 'Ficus-GuillermoPolito.185';
			package: #FicusExtras with: #FicusExtras;
			package: #FicusMetamodel with: 'FicusMetamodel-GuillermoPolito.16';
			package: #FicusRing with: 'FicusRing-GuillermoPolito.120';
			package: #FicusImpact with: #FicusImpact;
			package: #FicusStore with: #FicusStore;
			package: #FicusMonticello with: 'FicusMonticello-GuillermoPolito.63';
			package: #FicusMonticelloStore with: #FicusMonticelloStore;
			package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
			package: #FicusEpicea with: #FicusEpicea. ].

]

{ #category : #versions }
ConfigurationOfFicus >> version04: spec [
	<version: '0.4' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.4'.
		spec author: 'GuillermoPolito'.
		spec timestamp: '6/3/2015 15:57'.
		spec 
			project: #Epicea with: '4.8-baseline';
			project: #Yrupe with: '0.1-baseline';
			project: #PharoVersionsMiner with: '0.1-baseline'.
		spec 
			package: #Hiedra with: #Hiedra;
			package: #Ficus with: 'Ficus-GuillermoPolito.185';
			package: #FicusExtras with: #FicusExtras;
			package: #FicusMetamodel with: 'FicusMetamodel-GuillermoPolito.16';
			package: #FicusRing with: 'FicusRing-GuillermoPolito.121';
			package: #FicusImpact with: #FicusImpact;
			package: #FicusStore with: #FicusStore;
			package: #FicusMonticello with: 'FicusMonticello-GuillermoPolito.63';
			package: #FicusMonticelloStore with: #FicusMonticelloStore;
			package: #FicusMonticelloYrupe with: #FicusMonticelloYrupe;
			package: #FicusEpicea with: #FicusEpicea. ].

]

{ #category : #versions }
ConfigurationOfFicus >> version05: spec [
	<version: '0.5' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.5'.
		spec author: 'MartinDias'.
		spec timestamp: '6/25/2015 11:33'.
		spec 
			project: #Epicea with: '4.9';
			project: #Yrupe with: '1.0';
			project: #PharoVersionsMiner with: '1.0'.
		spec 
			package: #Hiedra with: 'Hiedra-MartinDias.135';
			package: #Ficus with: 'Ficus-MartinDias.189';
			package: #FicusExtras with: 'FicusExtras-MartinDias.6';
			package: #FicusMetamodel with: 'FicusMetamodel-MartinDias.20';
			package: #FicusRing with: 'FicusRing-MartinDias.126';
			package: #FicusImpact with: 'FicusImpact-MartinDias.82';
			package: #FicusStore with: 'FicusStore-MartinDias.105';
			package: #FicusMonticello with: 'FicusMonticello-MartinDias.66';
			package: #FicusMonticelloStore with: 'FicusMonticelloStore-MartinDias.4';
			package: #FicusMonticelloYrupe with: 'FicusMonticelloYrupe-MartinDias.18';
			package: #FicusEpicea with: 'FicusEpicea-MartinDias.34'. ].

]

{ #category : #versions }
ConfigurationOfFicus >> version06: spec [
	<version: '0.6' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.6'.
		spec author: 'MartinDias'.
		spec timestamp: '6/26/2015 15:33'.
		spec 
			project: #Epicea with: '5.0-baseline';
			project: #Yrupe with: '0.2-baseline';
			project: #PharoVersionsMiner with: '0.1-baseline'.
		spec 
			package: #Hiedra with: 'Hiedra-MartinDias.135';
			package: #Ficus with: 'Ficus-MartinDias.189';
			package: #FicusExtras with: 'FicusExtras-MartinDias.6';
			package: #FicusMetamodel with: 'FicusMetamodel-MartinDias.22';
			package: #FicusRing with: 'FicusRing-MartinDias.131';
			package: #FicusImpact with: 'FicusImpact-MartinDias.87';
			package: #FicusStore with: 'FicusStore-MartinDias.106';
			package: #FicusMonticello with: 'FicusMonticello-MartinDias.67';
			package: #FicusMonticelloStore with: 'FicusMonticelloStore-MartinDias.4';
			package: #FicusMonticelloYrupe with: 'FicusMonticelloYrupe-MartinDias.20';
			package: #FicusEpicea with: 'FicusEpicea-MartinDias.34'. ].

]
