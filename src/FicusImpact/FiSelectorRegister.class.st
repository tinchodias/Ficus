"
Stores the SISelector objects that corresponds to a given environment and supports collection-like enumerations
"
Class {
	#name : #FiSelectorRegister,
	#superclass : #Object,
	#instVars : [
		'environment',
		'selectors'
	],
	#category : #'FicusImpact-SendersImplementors'
}

{ #category : #'instance creation' }
FiSelectorRegister class >> environment: anEnvironment [
	^ super new
		initializeOnEnvironment: anEnvironment;
		yourself
]

{ #category : #'instance creation' }
FiSelectorRegister class >> new [
	^ self environment: RBBrowserEnvironment new
]

{ #category : #'adding/removing' }
FiSelectorRegister >> addMethod: aMethod [
	(self ensureSelector: aMethod selector) addImplementor: aMethod.
	aMethod messagesDo: [ :each | (self ensureSelector: each) addSender: aMethod ]
]

{ #category : #accessing }
FiSelectorRegister >> at: aSymbol [
	^ selectors like: aSymbol ifAbsent: [ FiSelector selector: aSymbol ]
]

{ #category : #enumerating }
FiSelectorRegister >> collect: aBlock [
	^ selectors collect: aBlock
]

{ #category : #enumerating }
FiSelectorRegister >> do: aBlock [
	^ selectors do: aBlock
]

{ #category : #private }
FiSelectorRegister >> ensureSelector: aSymbol [
	"Create a new entry for the selector aSymbol and add it to the registry"
	^ selectors like: aSymbol ifAbsent: [ selectors add: (FiSelector selector: aSymbol) ]
]

{ #category : #private }
FiSelectorRegister >> fill [

	"TODO: enhance.
	
	Example:
	{
	[ workingCopies := MCWorkingCopy allManagers ] timeToRun.
	[ ficusWorkingCopies := workingCopies collect: #ficusPackage ] timeToRun.
	[ ficusWorkingCopiesSet := (FiSet withValues: ficusWorkingCopies) ] timeToRun.
	[ register := FiSelectorRegister environment: ficusWorkingCopiesSet ] timeToRun.
	}.

	register sendersOf: #serialize:	
	"

	((environment values flatCollect: [ :package | package contents values ] as: OrderedCollection) 
		select: [ :each | each isFicusClass or: [ each isFicusTrait ] ])
		do: [ :behavior | behavior methods valuesDo: [ :method | self addMethod: method ] ] 
		displayingProgress: 'Filling registry, please wait...'
]

{ #category : #queries }
FiSelectorRegister >> implementorsOf: aSymbol [
	^ (self at: aSymbol) implementors
]

{ #category : #initialization }
FiSelectorRegister >> initializeOnEnvironment: anEnvironment [
	selectors := Set new.
	environment := anEnvironment.
	self fill
]

{ #category : #enumerating }
FiSelectorRegister >> reject: aBlock [
	^ selectors reject: aBlock
]

{ #category : #enumerating }
FiSelectorRegister >> select: aBlock [
	^ selectors select: aBlock
]

{ #category : #queries }
FiSelectorRegister >> sendersOf: aSymbol [
	^ (self at: aSymbol) senders
]

{ #category : #queries }
FiSelectorRegister >> transitiveSendersOf: aSymbol [ 
	^ self transitiveSendersOf: aSymbol set: IdentitySet new
]

{ #category : #'private-queries' }
FiSelectorRegister >> transitiveSendersOf: aString set: aSet [ 
	(self at: aString) senders ifNotEmpty: [ :senders |
		senders do: [ :each | 
			(aSet includes: each) ifFalse: [
				aSet add: each.
				self transitiveSendersOf: each selector set: aSet ]] ] .
	^ aSet
]
