Class {
	#name : #FiEditTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests'
}

{ #category : #tests }
FiEditTest >> testAddClass [

	| edit source result shot |
	source := FiDictionary new.
	shot := FiClass named: #A.
	
	edit := source at: #A equal: shot.
	result := source resultOf: edit.

	self assert: source valueByKey isEmpty.
	self assert: result valueByKey asSet equals: { shot } asSet.
]

{ #category : #tests }
FiEditTest >> testAddSharedPool [

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
FiEditTest >> testAddSharedPoolAndUpdateComment [

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
FiEditTest >> testRemoveClass [

	| edit source result shot intermediate |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot theName.
	result := intermediate resultOf: edit.
	
	self assert: source valueByKey isEmpty.
	self assert: intermediate valueByKey asSet equals: { shot } asSet.
	self assert: result valueByKey isEmpty.

]

{ #category : #tests }
FiEditTest >> testRemoveSharedPool [

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
FiEditTest >> testUpdateClass [

	| shot otherShot edit source result intermediate |
	source := FiDictionary new.
	shot := FiClass named: #A.
	otherShot := shot copy
		comment: 'hi';
		yourself.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: otherShot.
	result := intermediate resultOf: edit.
	
	self assert: source valueByKey isEmpty.
	self assert: intermediate valueByKey asSet equals: { shot } asSet.
	self assert: result valueByKey asSet equals: { otherShot } asSet.

]

{ #category : #tests }
FiEditTest >> testUpdateComment [

	| edit source result |
	source := FiClass named: #A.

	edit :=  source at: #comment equal: '42'.
	result := source resultOf: edit.
	
	self assert: source comment isEmpty.
	self assert: result comment equals: '42'.

]
