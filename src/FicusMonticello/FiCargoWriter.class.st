"
Get a Ficus model from a Cargo package description.
"
Class {
	#name : #FiCargoWriter,
	#superclass : #Object,
	#category : #'FicusMonticello-Writing'
}

{ #category : #writing }
FiCargoWriter >> ficusEnvironmentFromMcVersions: aListOfMcVersion [
	| environment |
	environment := Dictionary new.
	aListOfMcVersion collect: [ :mcVersion | | packageName |
		packageName := mcVersion package name.
		environment 
			at: packageName
			ifAbsentPut: (FiMonticelloWriter new 
				written: mcVersion snapshot
				name: packageName) ].
	
	^ environment values asFiSet asRFiEnvironment
]

{ #category : #writing }
FiCargoWriter >> written: aCGOPackageVersionReference [
	| mcVersions |
	mcVersions :=  Cargo new 
		package: aCGOPackageVersionReference;
		mcVersions.
	^ self ficusEnvironmentFromMcVersions: mcVersions
]
