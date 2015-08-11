Extension { #name : #CompiledMethod }

{ #category : #'*FicusMonticello' }
CompiledMethod >> remoteStringIfAbsent: absentBlock [

	| position |
	position := self filePosition.
	
	^ position isZero 
		ifTrue: absentBlock
		ifFalse: [ RemoteString newFileNumber: self fileIndex position: position ]
]
