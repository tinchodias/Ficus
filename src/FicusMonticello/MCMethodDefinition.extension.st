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

	| actualClass actualMethod remoteString actualSource |
	actualClass := self actualClassIfAbsent: [ ^ self source ].
	actualMethod := actualClass compiledMethodAt: self selector ifAbsent: [ ^ self source ].
	remoteString := actualMethod remoteStringIfAbsent: [ ^ self source ].
	actualSource := self source.

	^ remoteString string = actualSource
		ifTrue: [ remoteString asFiRemoteString ]
		ifFalse: [ actualSource ]
]
