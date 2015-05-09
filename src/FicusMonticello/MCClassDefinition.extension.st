Extension { #name : #MCClassDefinition }

{ #category : #'*FicusMonticello' }
MCClassDefinition >> actualClassIfAbsent: absentBlock [

	^ Smalltalk globals
		at: self className
		ifPresent: [ :class | class ]
		ifAbsent: absentBlock
]

{ #category : #'*FicusMonticello' }
MCClassDefinition >> ficusComment [

	| actualClass remoteString mcComment |
	mcComment := self comment.
	actualClass := self actualClassIfAbsent: [ ^ mcComment ].
	remoteString := actualClass organization commentRemoteStringIfAbsent: [ ^ mcComment ].

	^ remoteString string = mcComment
		ifTrue: [ remoteString asFiRemoteString ]
		ifFalse: [ mcComment ]
]
