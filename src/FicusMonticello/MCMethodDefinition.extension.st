Extension { #name : #MCMethodDefinition }

{ #category : #'*FicusMonticello' }
MCMethodDefinition >> actualClassIfAbsent: absentBlock [

	^ Smalltalk globals
		at: className
		ifPresent: [ :class | 
			classIsMeta
				ifTrue: [ class classSide ]
				ifFalse: [ class ] ]
		ifAbsent: absentBlock
]

{ #category : #'*FicusMonticello' }
MCMethodDefinition >> ficusSource [

	| actualClass actualMethod remoteString mcSource |
	mcSource := self source.
	actualClass := self actualClassIfAbsent: [ ^ mcSource ].
	actualMethod := actualClass compiledMethodAt: self selector ifAbsent: [ ^ mcSource ].
	remoteString := actualMethod sourcesRemoteStringIfAbsent: [ ^ mcSource ].

	^ remoteString string = mcSource
		ifTrue: [ remoteString asFiRemoteString ]
		ifFalse: [ mcSource ]
]
