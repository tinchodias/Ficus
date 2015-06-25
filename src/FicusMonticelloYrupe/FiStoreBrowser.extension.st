Extension { #name : #FiStoreBrowser }

{ #category : #'*FicusMonticelloYrupe' }
FiStoreBrowser classSide >> exampleFicusMonticelloYrupe [
	"
	[self exampleFicusMonticelloYrupe] timeToRun.
	"
	
	| pharos |
	pharos := (YrGitPharoExporter allTags first: 15) collect: [ :tag |
		"tag -> "(YrGitPharoExporter example1readTag: tag) ].

	^ self exampleWithStore: (FiMemoryStore exampleWithAll: pharos)
]
