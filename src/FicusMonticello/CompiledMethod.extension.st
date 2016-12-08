Extension { #name : #CompiledMethod }

{ #category : #'*FicusMonticello' }
CompiledMethod >> fileIndex [

	^SourceFiles fileIndexFromSourcePointer: self sourcePointer
]

{ #category : #'*FicusMonticello' }
CompiledMethod >> filePosition [

	^ SourceFiles filePositionFromSourcePointer: self sourcePointer
]

{ #category : #'*FicusMonticello' }
CompiledMethod >> remoteStringIfAbsent: absentBlock [

	| position |
	position := self filePosition.
	
	^ position isZero 
		ifTrue: absentBlock
		ifFalse: [ RemoteString newFileNumber: self fileIndex position: position ]
]
