Extension { #name : #ClassOrganization }

{ #category : #'*FicusMonticello' }
ClassOrganization >> commentRemoteStringIfAbsent: absentBlock [

	^ (comment isNotNil and: [ comment isKindOf: RemoteString ])
		ifTrue: [ comment ]
		ifFalse: absentBlock

]
