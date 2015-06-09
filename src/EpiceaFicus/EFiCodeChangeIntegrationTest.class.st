Class {
	#name : #EFiCodeChangeIntegrationTest,
	#superclass : #TestCase,
	#instVars : [
		'monitor',
		'classFactory',
		'aClass'
	],
	#category : #'EpiceaFicus-Tests'
}

{ #category : #running }
EFiCodeChangeIntegrationTest >> allLogEntriesWith: anEventClass [

	^ monitor workingCopy halt "events select: [ :each | each class = aClass ]"
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> categoryNameForTesting [

	^ #'EpiceaTestingWith-A-Really-WeirdCategoryName'

]

{ #category : #running }
EFiCodeChangeIntegrationTest >> countOfLogEntriesWith: anEventClass [

	^ (self allLogEntriesWith: anEventClass) size
]

{ #category : #running }
EFiCodeChangeIntegrationTest >> expectedFailures [ 

	^ self class testSelectors
]

{ #category : #running }
EFiCodeChangeIntegrationTest >> newWorkingCopy [
	
	| store packages |
	store := FiMemoryStore new.
	store name: 'Pharo-Codebase'.

	packages := EFiCodeMonitor current workingCopy snapshot.

	store 
		commitSnapshot: packages
		priors: FiSet new.

	^ store newWorkingCopy
]

{ #category : #running }
EFiCodeChangeIntegrationTest >> setUp [

	super setUp.
	
	monitor := 
		EFiCodeMonitor 
			outputWorkingCopy: self newWorkingCopy;
			systemAnnouncer: SystemAnnouncer uniqueInstance;
			yourself.
			
	classFactory := ClassFactoryForTestCase new.
	
" 	monitor enable."
]

{ #category : #running }
EFiCodeChangeIntegrationTest >> tearDown [
	super tearDown.
	
	monitor disable.	
	classFactory cleanUp.

	self class environment organization removeCategory: #'EpiceaTestingWith-A-Really-WeirdCategoryName'.

]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testCategoryAddition [

	self assert: (self countOfLogEntriesWith: EpCategoryAddition) equals: 0.

	self class environment organization addCategory: self categoryNameForTesting.
	
	self assert: (self countOfLogEntriesWith: EpCategoryAddition) equals: 1.
	self assert: (self allLogEntriesWith: EpCategoryAddition) first affectedPackageName equals: self categoryNameForTesting
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testCategoryRemoval [

	self class environment organization addCategory: self categoryNameForTesting.

	self assert: (self countOfLogEntriesWith: EpCategoryRemoval) equals: 0.

	self class environment organization removeCategory: self categoryNameForTesting.
	
	self assert: (self countOfLogEntriesWith: EpCategoryRemoval) equals: 1.
	self assert: (self allLogEntriesWith: EpCategoryRemoval) first affectedPackageName equals: self categoryNameForTesting
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testClassAddition [

	classFactory newClass.
	
	self assert: (self countOfLogEntriesWith: EpClassAddition) equals: 1.

]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testClassInstanceVariableAddition [

	aClass := classFactory newClass.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 0.
		
	aClass class addInstVarNamed: #x.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 1.
	self assert: (self allLogEntriesWith: EpClassModification) first hasMetaclassChanges
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testClassInstanceVariableRemoval [

	aClass := classFactory newClass.
	aClass class addInstVarNamed: #x.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 1.
		
	aClass class removeInstVarNamed: #x.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 2.
	self assert: ((self allLogEntriesWith: EpClassModification) allSatisfy: #hasMetaclassChanges)
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testClassRemoval [

	aClass := classFactory newClass.

	self assert: (self countOfLogEntriesWith: EpClassRemoval) equals: 0.

	aClass removeFromSystem.
	
	self assert: (self countOfLogEntriesWith: EpClassRemoval) equals: 1.

]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testInstanceVariableAddition [

	aClass := classFactory newClass.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 0.
		
	aClass addInstVarNamed: #x.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 1.
	self assert: (self allLogEntriesWith: EpClassModification) first hasNonMetaclassChanges
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testInstanceVariableRemoval [

	aClass := classFactory 
		newSubclassOf: Object 
		instanceVariableNames: 'x' 
		classVariableNames: ''.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 0.
	
	aClass removeInstVarNamed: #x.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 1.
	self assert: (self allLogEntriesWith: EpClassModification) first hasNonMetaclassChanges
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testMethodAddition [

	aClass := classFactory newClass.
	
	monitor enable.
	
	aClass compile: 'fortyTwo ^42'.

	self assert: self lastDelta equals: 1 halt
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testMethodModification [

	aClass := classFactory newClass.
	aClass compile: 'fortyTwo 42'.
	aClass compile: 'fortyTwo ^42'.

	self assert: (self countOfLogEntriesWith: EpMethodModification) equals: 1
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testMethodProtocolChange [

	aClass := classFactory newClass.
	aClass compile: 'fortyTwo ^42' classified: #accessing.
	aClass compile: 'fortyTwo ^42' classified: #testing.

	self assert: (self countOfLogEntriesWith: EpMethodModification) equals: 2
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testMethodRecompilationShouldNotLog [

	| headBeforeRecompiling |
	aClass := classFactory newClass.
	aClass compile: 'fortyTwo ^42'.

	headBeforeRecompiling := monitor head.

	aClass compile: 'fortyTwo ^42'.
	
	self assert: monitor head == headBeforeRecompiling
]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testRedundantClassDefinition [

	aClass := classFactory newClass.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 0.
		
	self class compiler evaluate: aClass definition.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 0.

	self class compiler evaluate: aClass theMetaClass definition.

	self assert: (self countOfLogEntriesWith: EpClassModification) equals: 0.

]

{ #category : #tests }
EFiCodeChangeIntegrationTest >> testRemoveTraitFromComposition [

	aClass := classFactory newClassUsing: TSizeTest.

	self 
		shouldnt: [ 
			aClass superclass 
				subclass: aClass name 
				uses: {} asTraitComposition 
				instanceVariableNames: ''
				classVariableNames: ''
				category: aClass category. ] 
		raise: MessageNotUnderstood
	
]
