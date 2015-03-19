Class {
	#name : #FiMonticelloWriter,
	#superclass : #Object,
	#category : #'FicusMonticello-Writing'
}

{ #category : #writing }
FiMonticelloWriter >> written: aMCSnapshot name: packageName [
	
	| visitor |
	visitor := FiMonticelloDefinitionVisitor new.
	
	aMCSnapshot definitions do: [ :each | each accept: visitor ].
	
	^ FiPackage builder
		name: packageName asSymbol;
		contents: visitor ficusPackageContents;
		new
]
