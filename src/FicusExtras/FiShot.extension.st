Extension { #name : #FiShot }

{ #category : #'*FicusExtras' }
FiShot >> editor [
	"Answer a FiShotEditor associated with this instance."
	
	^ self subclassResponsibility
]

{ #category : #'*FicusExtras' }
FiShot >> flattened [
	
	^ (Array streamContents: [ :stream |
		self 
			ficusDeepDo: [ :value :path | stream nextPut: path -> value ]
			basePath: FiPath root ])
		reversed

]
