"
Stores the senders and implementors that corresponds to a given environment and supports collection-like enumerations.


Example:
{
	[ workingCopies := MCWorkingCopy allManagers ] timeToRun.
	[ workingCopiesAndSnapshots := workingCopies collect: [ :package | package -> package completeSnapshot ] ] timeToRun.
	[ ficusWorkingCopies := workingCopiesAndSnapshots collect: [ :assoc | assoc key ficusPackageWith: assoc value ] ] timeToRun.
	[ ficusWorkingCopiesSet := (FiSet withValues: ficusWorkingCopies) ] timeToRun.
	[ register := FiSelectorRegister environment: ficusWorkingCopiesSet ] timeToRun.
}.

register sendersOf: #serialize:	

"
Class {
	#name : #RFiSelectorRegister,
	#superclass : #Object,
	#instVars : [
		'environment',
		'selectors'
	],
	#category : #'FicusImpact-Old-SendersImplementors'
}

{ #category : #'instance creation' }
RFiSelectorRegister class >> environment: anEnvironment [
	^ super new
		initializeOnEnvironment: anEnvironment;
		yourself
]

{ #category : #'instance creation' }
RFiSelectorRegister class >> new [
	^ self environment: RBBrowserEnvironment new
]

{ #category : #'adding/removing' }
RFiSelectorRegister >> addMethod: aMethod [
	(self ensureSelector: aMethod selector) addImplementor: aMethod.
	aMethod messagesDo: [ :each | (self ensureSelector: each) addSender: aMethod ]
]

{ #category : #accessing }
RFiSelectorRegister >> at: aSymbol [
	^ selectors like: aSymbol ifAbsent: [ RFiSelector selector: aSymbol ]
]

{ #category : #enumerating }
RFiSelectorRegister >> collect: aBlock [
	^ selectors collect: aBlock
]

{ #category : #enumerating }
RFiSelectorRegister >> do: aBlock [
	^ selectors do: aBlock
]

{ #category : #private }
RFiSelectorRegister >> ensureSelector: aSymbol [
	"Create a new entry for the selector aSymbol and add it to the registry"
	^ selectors like: aSymbol ifAbsent: [ selectors add: (RFiSelector selector: aSymbol) ]
]

{ #category : #private }
RFiSelectorRegister >> fill [

	((environment values flatCollect: [ :package | package contents values ] as: OrderedCollection) 
		select: [ :each | each isFicusClass or: [ each isFicusTrait ] ])
		do: [ :behavior | behavior methods valuesDo: [ :method | self addMethod: method ] ] 
		displayingProgress: 'Filling registry, please wait...'
]

{ #category : #queries }
RFiSelectorRegister >> implementorsOf: aSymbol [
	^ (self at: aSymbol) implementors
]

{ #category : #initialization }
RFiSelectorRegister >> initializeOnEnvironment: anEnvironment [
	selectors := Set new.
	environment := anEnvironment.
	self fill
]

{ #category : #enumerating }
RFiSelectorRegister >> reject: aBlock [
	^ selectors reject: aBlock
]

{ #category : #enumerating }
RFiSelectorRegister >> select: aBlock [
	^ selectors select: aBlock
]

{ #category : #queries }
RFiSelectorRegister >> sendersOf: aSymbol [
	^ (self at: aSymbol) senders
]

{ #category : #queries }
RFiSelectorRegister >> transitiveSendersOf: aSymbol [ 
	^ self transitiveSendersOf: aSymbol set: IdentitySet new
]

{ #category : #'private-queries' }
RFiSelectorRegister >> transitiveSendersOf: aString set: aSet [ 
	(self at: aString) senders ifNotEmpty: [ :senders |
		senders do: [ :each | 
			(aSet includes: each) ifFalse: [
				aSet add: each.
				self transitiveSendersOf: each selector set: aSet ]] ] .
	^ aSet
]
