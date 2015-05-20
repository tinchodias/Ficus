Extension { #name : #FiObject }

{ #category : #'*FicusExtras' }
FiObject >> editor [
	"Answer a FiShotEditor associated with this instance."
	
	^ self subclassResponsibility
]

{ #category : #'*FicusExtras' }
FiObject >> flattened [
	
	^ (Array streamContents: [ :stream |
		self 
			ficusDeepDo: [ :value :path | stream nextPut: path -> value ]
			basePath: FiPath root ])
		reversed

]
