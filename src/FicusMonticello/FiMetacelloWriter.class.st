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
	environment := OrderedCollection new.
	record := self recordVersion: aMetacelloVersion.
	
	(self packagesFromRecordedVersion: record)
		doWithIndex: [ :each :index | 	| package repository |
			repository := (record repositoryMap values at: index).
			package := self loadPackage: each fromRepository: repository.
			environment add: package.
		].
	
	^ environment asFiSet asRFiEnvironment
]
