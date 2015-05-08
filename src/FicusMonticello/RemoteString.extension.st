Extension { #name : #RemoteString }

{ #category : #'*FicusMonticello' }
RemoteString >> asFiRemoteString [

	^ FiRemoteString newFromSourcePointer: self sourcePointer
]
