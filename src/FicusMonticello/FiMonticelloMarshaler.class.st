Class {
	#name : #FiMonticelloMarshaler,
	#superclass : #Object,
	#category : #'FicusMonticello-Marshaling'
}

{ #category : #marshaling }
FiMonticelloMarshaler >> marshaled: aMCSnapshot name: packageName [
	
	| visitor |
	visitor := FiMonticelloDefinitionVisitor new.
	
	aMCSnapshot definitions do: [ :each | each accept: visitor ].
	
	^ FiPackage builder
		theName: packageName asSymbol;
		contents: visitor ficusPackageContents;
		new
]
