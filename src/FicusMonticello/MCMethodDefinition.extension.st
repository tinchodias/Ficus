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

	| actualClass actualMethod remoteString mcSource position fileIndex |
	mcSource := self source.
	actualClass := self actualClassIfAbsent: [ ^ mcSource ].
	actualMethod := actualClass compiledMethodAt: self selector ifAbsent: [ ^ mcSource ].

	position := SourceFiles filePositionFromSourcePointer: actualMethod sourcePointer.
	fileIndex := SourceFiles fileIndexFromSourcePointer: actualMethod sourcePointer.
	
	"HACK: .sources file has index 1 + position shouldn't be 0"
	remoteString := (fileIndex ~= 1 or: [ position isZero ])
		ifTrue: [ ^ mcSource ]
		ifFalse: [ RemoteString newFileNumber: fileIndex position: position ].
		
	^ remoteString string = mcSource
		ifTrue: [ remoteString asFiRemoteString ]
		ifFalse: [ mcSource ]
]
