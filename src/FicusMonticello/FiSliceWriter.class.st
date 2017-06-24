Class {
	#name : #FiSliceWriter,
	#superclass : #Object,
	#instVars : [
		'repository',
		'slice',
		'ficusPackages'
	],
	#category : #'FicusMonticello-Writing'
}

{ #category : #example }
FiSliceWriter class >> example15764 [
	"
	https://pharo.fogbugz.com/f/cases/15764/Clean-up-discouraged-uses-of-SourceFiles-and-friends-1
	=> integrated in Pharo 50112.
	Would it have the same impact in Pharo 40?
	"

	| repository slice |
	repository := self pharo50InboxRepository.
	slice := repository versionFromFileNamed: 'SLICE-Issue-15764-Clean-up-discouraged-uses-of-SourceFiles-and-friends-1-MartinDias.1.mcz'.

	^ (self new 
		repository: repository;
		slice: slice;
		run) ficusPackages
]

{ #category : #example }
FiSliceWriter class >> pharo50InboxRepository [
		
	^ MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Pharo50Inbox/main'
		user: ''
		password: ''.

]

{ #category : #private }
FiSliceWriter >> ficusPackageFrom: version [

	^ FiMonticelloWriter new 
			written: version snapshot 
			name: version package name
]

{ #category : #accessing }
FiSliceWriter >> ficusPackages [
	^ ficusPackages
]

{ #category : #accessing }
FiSliceWriter >> repository [
	^ repository
]

{ #category : #accessing }
FiSliceWriter >> repository: anObject [
	repository := anObject
]

{ #category : #accessing }
FiSliceWriter >> run [

	| versions |
	versions := slice dependencies collect: [ :each |
		repository 
			versionWithInfo: each versionInfo 
			ifAbsent: [ self error:'Could not load ', each versionInfo name ] ].

	ficusPackages := versions collect: [ :each | self ficusPackageFrom: each ]
]

{ #category : #accessing }
FiSliceWriter >> slice [
	^ slice
]

{ #category : #accessing }
FiSliceWriter >> slice: anObject [
	slice := anObject
]
