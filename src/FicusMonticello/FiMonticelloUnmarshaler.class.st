Class {
	#name : #FiMonticelloUnmarshaler,
	#superclass : #Object,
	#category : #FicusMonticello
}

{ #category : #private }
FiMonticelloUnmarshaler >> classInstVarNamesFrom: aFiClass [ 
	
	^ aFiClass metaclass layout slotNames
]

{ #category : #private }
FiMonticelloUnmarshaler >> classVarNamesFrom: aFiClass [ 
	
	^ aFiClass classPool
]

{ #category : #private }
FiMonticelloUnmarshaler >> instVarNamesFrom: aFiClass [ 
	
	^ aFiClass layout slotNames
]

{ #category : #private }
FiMonticelloUnmarshaler >> monticelloClassDefinitionFrom: aFiClass [ 

	^ MCClassDefinition
		name: aFiClass theName
		superclassName: aFiClass superclass
		traitComposition: '{}' "TODO"
		classTraitComposition: '{}'
		category: aFiClass category
		instVarNames: (self instVarNamesFrom: aFiClass)
		classVarNames: (self classVarNamesFrom: aFiClass) values
		poolDictionaryNames: aFiClass sharedPools values
		classInstVarNames: (self classInstVarNamesFrom: aFiClass)
		type: (self typeOfClassFrom: aFiClass)
		comment: aFiClass comment
		commentStamp: ''
]

{ #category : #private }
FiMonticelloUnmarshaler >> monticelloDefinitionsFrom: aFiDictionary [ 

	| definitions |
	definitions := Set new.
	
	aFiDictionary stepsAndValuesDo: [ :className :aFicusClass |
		definitions 
			add: (self monticelloClassDefinitionFrom: aFicusClass);
			addAll: (self monticelloMethodDefinitionsFrom: aFicusClass className: aFicusClass theName classIsMeta: false);
			addAll: (self monticelloMethodDefinitionsFrom: aFicusClass metaclass className: aFicusClass theName classIsMeta: true) ].
	
	^ definitions
]

{ #category : #private }
FiMonticelloUnmarshaler >> monticelloMethodDefinitionsFrom: aFicusBehavior className: className classIsMeta: classIsMeta [

	| methods |
	methods := Set new.

	aFicusBehavior methods stepsAndValuesDo: [ :selector :aFicusMethod | 
		methods add: 
			(MCMethodDefinition
				className: className
				classIsMeta: classIsMeta
				selector: aFicusMethod selector
				category: aFicusMethod protocol
				timeStamp: ''
				source: aFicusMethod sourceCode) ].
	
	^ methods

]

{ #category : #private }
FiMonticelloUnmarshaler >> typeOfClassFrom: aFiClass [ 
	
	^ #normal
]

{ #category : #unmarshaling }
FiMonticelloUnmarshaler >> unmarshaled: aFiDictionary [ 
	
	^ MCSnapshot fromDefinitions: (self monticelloDefinitionsFrom: aFiDictionary)
]
