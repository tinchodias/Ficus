Class {
	#name : #FiShotTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiShotTest >> testAddSharedPool [

	| edit source result |
	source := FiClass named: #A.

	edit := 
		source 
			at: #sharedPools
			edit: [ :sharedPools | sharedPools include: #X ].
	result := source resultOf: edit.

	self assert: source sharedPools values isEmpty.
	self assert: result sharedPools values asSet equals: { #X } asSet.

]

{ #category : #tests }
FiShotTest >> testAddSharedPoolAndUpdateComment [

	| edit source result |
	source := FiClass named: #A.

	edit := source edits: {
		source 
			at: #sharedPools
			edit: [ :sharedPools | sharedPools include: #X ].
		source
			at: #comment
			equal: '42'.
		}.
			
	result := source resultOf: edit.

	self assert: source sharedPools values isEmpty.
	self assert: source comment isEmpty.
	self assert: result sharedPools values asSet equals: { #X } asSet.
	self assert: result comment equals: '42'.

]

{ #category : #tests }
FiShotTest >> testRemoveSharedPool [

	| edit preSource source result |
	preSource := FiClass named: #A.

	edit := 
		preSource 
			at: #sharedPools
			edit: [ :sharedPools | sharedPools include: #X ].
	source := preSource resultOf: edit.

	edit := 
		source 
			at: #sharedPools
			edit: [ :sharedPools | sharedPools exclude: #X ].
	result := source resultOf: edit.

	self assert: source sharedPools values asSet equals: { #X } asSet.
	self assert: result sharedPools values isEmpty.

]

{ #category : #tests }
FiShotTest >> testUpdateComment [

	| edit source result |
	source := FiClass named: #A.

	edit :=  source at: #comment equal: '42'.
	result := source resultOf: edit.
	
	self assert: source comment isEmpty.
	self assert: result comment equals: '42'.

]
