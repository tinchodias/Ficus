Extension { #name : #MCRepositoryGroup }

{ #category : #'*FicusMonticello' }
MCRepositoryGroup >> versionWithInfo: aVersionInfo ifAbsent: aBlock [
	self repositoriesDo: [:ea | (ea versionWithInfo: aVersionInfo) ifNotNil: [:v | ^ v]].
	^aBlock value
]
