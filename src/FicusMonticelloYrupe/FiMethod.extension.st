Extension { #name : #FiMethod }

{ #category : #'*FicusMonticelloYrupe' }
FiMethod >> yrupeDefaultEncoder [

	^ self yrupeLeafEncoder
]

{ #category : #'*FicusMonticelloYrupe' }
FiMethod >> yrupeLeafEncoder [

	^ YrMethodEncoding new
]
