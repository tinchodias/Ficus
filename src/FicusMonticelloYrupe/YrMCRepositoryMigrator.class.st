Class {
	#name : #YrMCRepositoryMigrator,
	#superclass : #Object,
	#instVars : [
		'gitRepository',
		'monticelloRepository',
		'limit',
		'packageName',
		'commitByVersionNode'
	],
	#category : #'FicusMonticelloYrupe-Migration-Old'
}

{ #category : #examples }
YrMCRepositoryMigrator class >> example1 [

	"
	self example1  
	"

	"git repository"
	| directory gitRepository |
	directory := FileSystem workingDirectory / 'yrupeFuelTests'.
	gitRepository := LGitRepository on: directory.
	gitRepository
		create;
		init.

	^ self new
		gitRepository: gitRepository;
		packageName: 'FuelTests';
		monticelloRepository: FiMonticelloVersionGraphBuilder fuelRepository;
		limit: 5;
		migrate.
]

{ #category : #private }
YrMCRepositoryMigrator >> doMigrate: aVersionNode branch: aBranchPath [

	^ YrCommitWriter new
		repository: gitRepository;
		reference: aBranchPath;
		userName: (self gitAuthorFor: aVersionNode);
		userEmail: (self gitEmailFor: aVersionNode);
		signatureDateAndTime: (self gitDateAndTimeFor: aVersionNode);
		message: (self gitMessageFor: aVersionNode);
		parents: (self gitParentsFor: aVersionNode branch: aBranchPath);
		commit: (self ficusModelFor: aVersionNode).
]

{ #category : #private }
YrMCRepositoryMigrator >> ficusModelFor: aVersionNode [
		
	^ FiMonticelloWriter new 
		written: (self snapshotFor: aVersionNode)
		name: packageName

]

{ #category : #private }
YrMCRepositoryMigrator >> gitAuthorFor: aVersionNode [ 

	^ aVersionNode author
]

{ #category : #private }
YrMCRepositoryMigrator >> gitDateAndTimeFor: aVersionNode [

	^ aVersionNode versionInfo timeStamp
]

{ #category : #private }
YrMCRepositoryMigrator >> gitEmailFor: aVersionNode [ 

	^ aVersionNode author asLowercase, '@fake.mail.com'
]

{ #category : #private }
YrMCRepositoryMigrator >> gitMessageFor: aVersionNode [ 

	^ (String streamContents: [ :stream |
		stream 
			nextPutAll: aVersionNode versionInfo message; cr; cr;
			nextPutAll: '# Original MCVersion summary #'; cr; cr;
			nextPutAll: aVersionNode versionInfo summary; cr; cr ]) withUnixLineEndings
]

{ #category : #private }
YrMCRepositoryMigrator >> gitParentsFor: aVersionNode branch: aBranchPath [
	"Answer git parents, ensuring each one ancestor is migrated."

	^ aVersionNode ancestors collect: [ :ancestorNode | 
		self migrate: ancestorNode branch: aBranchPath ]
]

{ #category : #accessing }
YrMCRepositoryMigrator >> gitRepository: aLGitRepository [ 
	
	gitRepository := aLGitRepository
]

{ #category : #initialization }
YrMCRepositoryMigrator >> initialize [

	super initialize.

	commitByVersionNode := Dictionary new
]

{ #category : #accessing }
YrMCRepositoryMigrator >> limit: anInteger [ 

	limit := anInteger 
]

{ #category : #migrating }
YrMCRepositoryMigrator >> migrate [

	| tipNodes |
	tipNodes := FiMonticelloVersionGraphBuilder new
		repository: monticelloRepository;
		packageName: packageName;
		build;
		leafNodes.
		
	tipNodes withIndexDo: [ :aNode :index |
		| branch |
		branch := 'master', index asString.

		self migrate: aNode branch: branch.
		
		gitRepository 
			branch_create: (LGitReference of: gitRepository)
			repo: gitRepository 
			branch_name: branch
			target: (commitByVersionNode at: aNode)
			force: 0
			signature: gitRepository defaultSignature 
			log_message: 'yrupe'.
			
		gitRepository
			repository_set_head: gitRepository
			refname: branch
			signature: gitRepository defaultSignature
			log_message: 'yrupe'.
		
		]
]

{ #category : #migrating }
YrMCRepositoryMigrator >> migrate: aVersionNode branch: aBranchPath [

	"Escape if already migrated"
	^ commitByVersionNode 
		at: aVersionNode 
		ifAbsentPut: [ self doMigrate: aVersionNode branch: aBranchPath ].
]

{ #category : #accessing }
YrMCRepositoryMigrator >> monticelloRepository: aMCSmalltalkhubRepository [ 
	
	monticelloRepository := aMCSmalltalkhubRepository
]

{ #category : #accessing }
YrMCRepositoryMigrator >> packageName: aString [ 

	packageName := aString
]

{ #category : #private }
YrMCRepositoryMigrator >> snapshotFor: aVersionNode [
		
	^ (monticelloRepository 
			versionWithInfo: aVersionNode versionInfo 
			ifAbsent: [ ^ MCSnapshot empty ])
			snapshot
]
