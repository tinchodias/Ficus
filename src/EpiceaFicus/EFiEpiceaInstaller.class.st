Class {
	#name : #EFiEpiceaInstaller,
	#superclass : #Object,
	#instVars : [
		'registry',
		'epiceaMonitor',
		'pharoCodeMonitor',
		'epiceaRepositoryWorkingCopy'
	],
	#classInstVars : [
		'current'
	],
	#category : #'EpiceaFicus-Repositories'
}

{ #category : #convenience }
EFiEpiceaInstaller class >> ensurePharoGitRepositoryUpToDateAt: directory [
	
	directory exists
		ifTrue: [ 
			(LGitRemote
				of: (LGitRepository on: directory) open
				named: 'origin'
				url: self pharoMetamodelGitUrl
				fetchSpec: '+refs/heads/*:refs/remotes/origin/*') pull ]
		ifFalse: [ 
			EFiGitRepository 
				cloneWithoutCheckout: self pharoMetamodelGitUrl
				in: directory ]
]

{ #category : #accessing }
EFiEpiceaInstaller class >> pharoMetamodelGitUrl [
		
	^ 'https://github.com/tinchodias/pharo-core-yrupe-4' 
]

{ #category : #convenience }
EFiEpiceaInstaller class >> syncMCWorkingCopiesWith: workingCopy [
	
	| edits |
	edits := MCWorkingCopy allManagers 
		select: [ :each |
			each modified or: [ (workingCopy snapshot packages hasValueAt: each packageName) not ] ]
		thenCollect: [ :each |
			FiSubEdit 
				path: (FiPackageSpot named: each package name) 
				equal: each ficusPackage ].

	workingCopy applyEdit: (FiEdit fromAll: edits)
]

{ #category : #'as yet unclassified' }
EFiEpiceaInstaller >> install [
	"
	self new install; yourself
	"

	| currentPharoPackages pharoCodeWorkingCopy |
	registry := FiWorkingCopyRegistry new.
	
	"create epicea repository"
	epiceaRepositoryWorkingCopy := self newEpiceaRepository newWorkingCopy.

	"create epicea monitor"
	epiceaMonitor := 
		EFiEpiceaMonitor new
			outputWorkingCopy: epiceaRepositoryWorkingCopy;
			workingCopyRegistry: registry; "<-- implement!"
			yourself.
	epiceaMonitor enable.
	
	"create pharo metamodel wc"
	currentPharoPackages := YrWorkingCopiesCacheFiller packagesAfterPrefillReadCache.
	pharoCodeWorkingCopy := 
		self newPharoGitRepository
			revisionAtGitTag: SystemVersion current highestUpdate asString
			ifPresent: [ :revision | revision newWorkingCopy ] "<- should epicea register this checkout?"
			ifAbsent: [ self notYetImplemented ].
	registry addWorkingCopy: pharoCodeWorkingCopy.

	"create pharo metamodel monitor"
	pharoCodeMonitor := 
		EFiCodeMonitor new
			outputWorkingCopy: pharoCodeWorkingCopy;
			systemAnnouncer: SystemAnnouncer uniqueInstance;
			yourself.
	pharoCodeMonitor enable.

	"sync pharo metamodel wc"
	pharoCodeWorkingCopy snapshot: (FiEnvironment withAll: currentPharoPackages).
	
	"annotate all those changes as SYNC"
	"TODO"

"	registry 
		addWorkingCopy: pharoCodeWorkingCopy; 
		addWorkingCopy: self newPharoAnnotationWorkingCopy; 
		yourself"
]

{ #category : #'as yet unclassified' }
EFiEpiceaInstaller >> newEpiceaRepository [

	^ EFiEpiceaRepository new
		fileReference: './epicea-ficus-dev' asFileReference ensureCreateDirectory;
		yourself
]

{ #category : #'as yet unclassified' }
EFiEpiceaInstaller >> newPharoGitRepository [
	
	| directory |
	directory := FileSystem workingDirectory / 'yrupe-dev-pharo'.
	self class ensurePharoGitRepositoryUpToDateAt: directory.	
	
	^ EFiGitRepository new
		repositoryFileReference: directory;
		yourself
]
