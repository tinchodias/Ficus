Extension { #name : #FiStoreBrowser }

{ #category : #'*FicusMonticello' }
FiStoreBrowser classSide >> exampleMonticello [
	"
	self exampleMonticello
	"

	^ self exampleWithStore: (FiMonticelloStore forPackageNamed: #Tetris)
]
