Class {
	#name : #FiMetacelloWriter,
	#superclass : #Object,
	#category : #'FicusMonticello-Writing'
}

{ #category : #'as yet unclassified' }
FiMetacelloWriter >> loadPackage: each fromRepository: aRepositoryOrArray [

	"Sometimes metacello gives us arrays and sometimes repositories."
	| repository version |
	repository := aRepositoryOrArray isCollection
		ifTrue: [ aRepositoryOrArray anyOne ]
		ifFalse: [ aRepositoryOrArray ].
	version := repository versionFromFileNamed: each , '.mcz'.
	^ FiMonticelloWriter new 
		written: version snapshot
		name: version package name.
]

{ #category : #'as yet unclassified' }
FiMetacelloWriter >> packagesFromRecordedVersion: record [
	
	"We remove repeated packages while keeping order"
	^ record loadedPackages
		inject: OrderedCollection new
		into: [ :each :acum | (each includes: acum) ifFalse: [ each addLast: acum ]. each ].
]

{ #category : #'as yet unclassified' }
FiMetacelloWriter >> recordVersion: aMetacelloVersion [
	
	[ ^(aMetacelloVersion ignoreImage: true) record.] 
		on: MCMergeOrLoadWarning do: [ :e | "we merge" e resume: false ]
]

{ #category : #'as yet unclassified' }
FiMetacelloWriter >> written: aMetacelloVersion [
	
	| environment record  |
	environment := Dictionary new.
	record := self recordVersion: aMetacelloVersion.
	
	record loadDirective packageDirectivesDo: [:directive | | repository package |
		repository := (record repositoryMap 
			at: directive externalReference packageName
			ifAbsent: [ record repositoryMap 
										at: directive externalReference name ]).
		package := self loadPackage: directive file fromRepository: repository.
		environment at: package name ifAbsentPut: package.
	].
	
	^ environment values asFiSet asRFiEnvironment
]
