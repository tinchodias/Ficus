Extension { #name : #GLMSmalltalkCodeModel }

{ #category : #'*FicusRing' }
GLMSmalltalkCodeModel >> environment [ 
	
	^ self highlightSmalltalkContext
		ifNotNil: [ self highlightSmalltalkContext environment ]
		ifNil: [ super environment ]
]
