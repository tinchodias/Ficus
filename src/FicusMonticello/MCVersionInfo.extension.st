Extension { #name : #MCVersionInfo }

{ #category : #'*FicusMonticello' }
MCVersionInfo >> packageName [

	^ self name copyUpToLast: $-
]
