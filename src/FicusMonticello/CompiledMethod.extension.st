Extension { #name : #CompiledMethod }

{ #category : #'*FicusMonticello' }
CompiledMethod >> sourcesRemoteStringIfAbsent: absentBlock [
	"Answer a RemoteString in the case my source code is stored in the .sources file.
	Else, value the block."

	| position fileIndex |
	position := self filePosition.
	fileIndex := self fileIndex.
	
	"source file has index 1 + position shouldn't be 0"
	^ (fileIndex ~= 1 or: [ position isZero ])
		ifTrue: absentBlock
		ifFalse: [ RemoteString newFileNumber: self fileIndex position: position ]
]
