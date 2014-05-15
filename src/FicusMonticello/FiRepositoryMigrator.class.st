Class {
	#name : #FiRepositoryMigrator,
	#superclass : #Object,
	#instVars : [
		'gitRepository',
		'monticelloRepository',
		'limit',
		'packageName',
		'commitByVersionNode'
	],
	#category : #'FicusMonticello-Graph'
}

{ #category : #'as yet unclassified' }
FiRepositoryMigrator class >> example1 [

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

{ #category : #migrating }
FiRepositoryMigrator >> doMigrate: aVersionNode branch: aBranchPath [

	^ YrCommitMarshaler new
		repository: gitRepository;
		reference: aBranchPath;
		userName: (self gitAuthorFor: aVersionNode);
		userEmail: (self gitEmailFor: aVersionNode);
		message: (self gitMessageFor: aVersionNode);
		parents: (self gitParentsFor: aVersionNode branch: aBranchPath);
		commit: (self ficusModelFor: aVersionNode).
]

{ #category : #migrating }
FiRepositoryMigrator >> ficusModelFor: aVersionNode [
		
	^ FiMonticelloMarshaler new marshaled: (self snapshotFor: aVersionNode)

]

{ #category : #'as yet unclassified' }
FiRepositoryMigrator >> gitAuthorFor: aVersionNode [ 

	AUTHORS add: (aVersionNode author).
	
^ (aVersionNode author)
]

{ #category : #'as yet unclassified' }
FiRepositoryMigrator >> gitEmailFor: aVersionNode [ 

	^ aVersionNode author asLowercase, '@gmail.com'
]

{ #category : #'as yet unclassified' }
FiRepositoryMigrator >> gitMessageFor: aVersionNode [ 

	^ String streamContents: [ :stream |
		stream 
			nextPutAll: '# Ficus migration #'; cr; cr;
			nextPutAll: 'Original commit: '; cr; cr;
			nextPutAll: aVersionNode versionInfo summary; cr ]
]

{ #category : #'as yet unclassified' }
FiRepositoryMigrator >> gitParentsFor: aVersionNode branch: aBranchPath [
	"Answer git parents, ensuring each one ancestor is migrated."

	^ aVersionNode ancestors collect: [ :ancestorNode | 
		self migrate: ancestorNode branch: aBranchPath ]
]

{ #category : #accessing }
FiRepositoryMigrator >> gitRepository: aLGitRepository [ 
	
	gitRepository := aLGitRepository
]

{ #category : #initialization }
FiRepositoryMigrator >> initialize [

	super initialize.

	commitByVersionNode := Dictionary new
]

{ #category : #accessing }
FiRepositoryMigrator >> limit: anInteger [ 

	limit := anInteger 
]

{ #category : #migrating }
FiRepositoryMigrator >> migrate [

	| tipNodes |
	tipNodes := FiMonticelloVersionGraphBuilder new
		repository: monticelloRepository;
		packageName: packageName;
		build;
		leafNodes.
		
	tipNodes withIndexDo: [ :aNode :index |
		self migrate: aNode branch: ('refs/heads/master', index asString) ]
]

{ #category : #migrating }
FiRepositoryMigrator >> migrate: aVersionNode branch: aBranchPath [

	"Escape if already migrated"
	^ commitByVersionNode 
		at: aVersionNode 
		ifAbsentPut: [ self doMigrate: aVersionNode branch: aBranchPath ].
]

{ #category : #accessing }
FiRepositoryMigrator >> monticelloRepository: aMCSmalltalkhubRepository [ 
	
	monticelloRepository := aMCSmalltalkhubRepository
]

{ #category : #accessing }
FiRepositoryMigrator >> packageName: aString [ 

	packageName := aString
]

{ #category : #migrating }
FiRepositoryMigrator >> snapshotFor: aVersionNode [
		
	^ (monticelloRepository 
			versionWithInfo: aVersionNode versionInfo 
			ifAbsent: [ ^ MCSnapshot empty ])
			snapshot
]
