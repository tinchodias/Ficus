Extension { #name : #FiStoreBrowser }

{ #category : #'*FicusEpicea' }
FiStoreBrowser classSide >> exampleEpiceaFicusStore [
	"
	self exampleEpiceaFicusStore.
	"

	^ self exampleWithStore: (FiEpiceaStore forPackageNamed: #FicusStore)
]

{ #category : #'*FicusEpicea' }
FiStoreBrowser classSide >> exampleEpiceaTetris [
	"
	Gofer it package: #Tetris; load.
	self exampleEpiceaTetris.
	"

	^ self exampleWithStore: (FiEpiceaStore forPackageNamed: #Tetris)
]
