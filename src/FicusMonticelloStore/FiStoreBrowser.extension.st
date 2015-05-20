Extension { #name : #FiStoreBrowser }

{ #category : #'*FicusMonticelloStore' }
FiStoreBrowser classSide >> exampleMonticello [
	"
	self exampleMonticello
	"

	^ self exampleWithStore: (FiMonticelloStore forPackageNamed: #Tetris)
]
