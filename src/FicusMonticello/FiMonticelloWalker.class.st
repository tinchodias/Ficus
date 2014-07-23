"
I know how to enumerate versions.

Example:


""repository := 
	MCHttpRepository
		location: 'http://smalltalkhub.com/mc/Pharo/Fuel/main'
		user: ''
		password: ''.
""
repository := 
	MCRepositoryGroup withRepositories: {
		MCHttpRepository
			location: 'http://smalltalkhub.com/mc/Pharo/Fuel/main'
			user: ''
			password: ''.
		(MCHttpRepository
			location: 'http://smalltalkhub.com/mc/Pharo/Pharo30Inbox/main'
			user: ''
			password: '').
		(MCHttpRepository
			location: 'http://smalltalkhub.com/mc/Pharo/Pharo30/main'
			user: ''
			password: ''). }.

""
repository := MCCacheRepository uniqueInstance.
""
	
initialVersionInfo := 
	(MCWorkingCopy allManagers 
		detect: [ :each | each packageName = 'FuelTests' ]) 
		ancestry ancestors first.
			
walker := FiMonticelloWalker new
	repository: repository;
	addVersionInfo: initialVersionInfo;
	yourself.	
	
Array streamContents: [ :stream |
	| limit |
	limit := 25.
	[ walker atEnd or: [ limit <= 0 ] ] whileFalse: [ 
		limit := limit - 1.
		stream nextPut: walker next ] ].

"
Class {
	#name : #FiMonticelloWalker,
	#superclass : #Object,
	#instVars : [
		'repository',
		'pendingVersionInfos',
		'alreadySeenVersionInfos'
	],
	#category : #'FicusMonticello-Walker'
}

{ #category : #adding }
FiMonticelloWalker >> addVersionInfo: aVersionInfo [
	
	pendingVersionInfos add: aVersionInfo
]

{ #category : #testing }
FiMonticelloWalker >> atEnd [

	^ self nextVersion isNil
]

{ #category : #initialization }
FiMonticelloWalker >> initialize [

	super initialize.
	
	pendingVersionInfos := Set new.
	alreadySeenVersionInfos := Set new.
]

{ #category : #accessing }
FiMonticelloWalker >> next [

	| nextVersion |	
	nextVersion := self nextVersion.

	alreadySeenVersionInfos add: nextVersion info.
	pendingVersionInfos remove: nextVersion info.	
	pendingVersionInfos addAll: (nextVersion info ancestors copyWithoutAll: alreadySeenVersionInfos).

	^ nextVersion
]

{ #category : #private }
FiMonticelloWalker >> nextVersion [

	(pendingVersionInfos sorted: [ :a :b | a timeStamp >= b timeStamp ]) do: [ :each |
		(repository 
			versionWithInfo: each 
			ifAbsent: [ pendingVersionInfos remove: each "since it's not found". nil ]) 
			ifNotNil: [ :version | ^ version ] ].
		
	^ nil
]

{ #category : #accessing }
FiMonticelloWalker >> repository: anObject [
	
	repository := anObject
]
