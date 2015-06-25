Extension { #name : #FiStoreBrowser }

{ #category : #'*FicusMonticelloYrupe' }
FiStoreBrowser classSide >> exampleFicusMonticelloYrupe [
	"
	[self exampleFicusMonticelloYrupe] timeToRun.
	"
	
	| pharos |
	pharos := (YrPharoMigrator allTags first: 15) collect: [ :tag |
		"tag -> "(YrPharoMigrator example1readTag: tag) ].

	^ self exampleWithStore: (FiMemoryStore exampleWithAll: pharos)
]
