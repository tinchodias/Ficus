Extension { #name : #RFiEnvironmentBrowser }

{ #category : #'*FicusMonticelloYrupe' }
RFiEnvironmentBrowser classSide >> example4yrupe [
	"
	self example4yrupe
	"
	
	^ self openOn: (YrPharoMigrator example1readTag: '30005') asRFiEnvironment
]
