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
	
	^ FiPackage newFromStepsAndValues: 
		(Dictionary new
			at: #theName put: packageName asSymbol;
			at: #contents put: visitor ficusPackageContents;
			yourself)	
]
